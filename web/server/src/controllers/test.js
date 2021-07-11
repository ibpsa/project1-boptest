import {addJobToQueue} from './job';
import {getWorkerData} from './just-in-time-data.js';
import {getS3KeyForTestcaseID} from './testcase.js';

function promiseTaskLater(task, time, ...args) {
  return new Promise((resolve, reject) => {
    setTimeout(async () => {
      try {
        await task(...args);
        resolve();
      } catch (e) {
        reject(e);
      }
    }, time);
  });
};

function setU(site_ref, u, redis) {
  return new Promise((resolve, reject) => {
    redis.hset(site_ref, 'u', JSON.stringify(u), (err) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

function sendStopSignal(site_ref, pub) {
  pub.publish(site_ref, "stop");
}

export function getStatus(testcaseid, db, redis) {
  return new Promise((resolve, reject) => {
    redis.hexists(testcaseid, 'status', async (existserr, existsdata) => {
      if (existserr) {
          reject(existserr)
      } else {
        if (existsdata) {
          redis.hget(testcaseid, 'status', (err, data) => {
            if (err) {
              reject(err)
            } else {
              resolve(data)
            }
          })
        } else {
          // If there is no status in redis, see if the test exists in the db, and if it does
          // consider status "Stopped". This should be reconsidered if testcase id and test id are separated
          const testcases = db.collection('testcases')
          const query = {testcaseid}
          const doc = await testcases.findOne(query)
          if (doc) {
            resolve("Stopped")
          } else {
            resolve("Unknown")
          }
        }
      }
    })
  })
};

export async function waitForStatus(id, db, redis, desiredStatus, count, maxCount) {
  // The default maxCount is 30, which will result in waiting up to 30 seconds
  maxCount = typeof maxCount !== 'undefined' ? maxCount : 30
  // The default starting count is 0
  count = typeof count !== 'undefined' ? count : 0
  const currentStatus = await getStatus(id, db, redis);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count == maxCount) {
    throw(`Timeout waiting for test: ${id} to reach status: ${desiredStatus}`);
  } else {
    // check status every 1000 miliseconds
    await promiseTaskLater(waitForStatus, 1000, id, db, redis, desiredStatus, count, maxCount);
    count++
  }
};

export function setStatus(site_ref, stat, redis) {
  return new Promise((resolve, reject) => {
    redis.hset(site_ref, 'status', stat, (err) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

export function getY(site_ref, redis) {
  return new Promise((resolve, reject) => {
    redis.hget(site_ref, 'y', (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
}

export function getForecastParameters(site_ref, redis) {
  return new Promise((resolve, reject) => {
    redis.hget(site_ref, 'forecast_parameters', (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
}

export function setForecastParameters(site_ref, horizon, interval, redis) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({horizon: Number(horizon), interval: Number(interval)})
    redis.hset(site_ref, 'forecast_parameters', data, (err) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
}

export function getForecast(site_ref, redis) {
  return getWorkerData(site_ref, "forecast", redis, {});
}

export async function initialize(testcaseid, start_time, warmup_period, db, redis, sqs) {
  const key = getS3KeyForTestcaseID(testcaseid)
  await setStatus(testcaseid, "Starting", redis)
  await addJobToQueue("runSite", {testcaseid, key, start_time, warmup_period}, sqs)
  await waitForStatus(testcaseid, db, redis, "Running")
  return await getY(testcaseid, redis)
}

export async function getScenario(testid, db, redis) {
  const scenario = await new Promise((resolve, reject) => {
    // Look in redis first for a cached value,
    // running tests should have a cached value.
    // Fallback to the testcase default from database
    redis.hget(testid, 'scenario', (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
  // Running tests should have a scenario in redis.
  // If there is no running test then look for the default
  // value stored in db
  if (scenario) {
    return scenario
  } else {
    const testcases = db.collection('testcases')
    const query = { testcaseid: testid }
    const doc = await testcases.findOne(query, { scenario: 1 })
    return doc.scenario
  }
}

async function startNewScenario(testcaseid, scenario, db, redis, sqs, pub) {
  // If the test is already running then stop it first
  if (getStatus(testcaseid, db, redis) != "Stopped") {
    await stop(testcaseid, db, redis, pub)
  }
  
  await storeScenario(testcaseid, scenario, redis)

  // Starting a test job will initialize it with the given scenario
  await setStatus(testcaseid, "Starting", redis)
  const key = getS3KeyForTestcaseID(testcaseid)
  await addJobToQueue("runSite", { testcaseid, key }, sqs)
  await waitForStatus(testcaseid, db, redis, "Running")
  
  return await new Promise((resolve, reject) => {
    redis.hget(testcaseid, 'scenario_result', (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
}

async function storeScenario(site_ref, scenario, redis) {
  // Store the given scenario in redis
  return await new Promise((resolve, reject) => {
    redis.hset(site_ref, 'scenario', JSON.stringify(scenario), (err) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

export async function setScenario(site_ref, scenario, db, redis, sqs, pub) {
  const stopped = getStatus(site_ref, db, redis) == "Stopped"

  if (scenario['time_period'] || stopped) {
    // If the scenario has a time period or the test is not running, 
    // then we start an new job/test
    // This will start the new scenario according to the scenario parameters in redis
    return startNewScenario(site_ref, scenario, db, redis, sqs, pub)
  } else {
    // Otherwise just send a signal for the already running test to reset the scenario
    // return the response from the testcase
    await storeScenario(site_ref, scenario, redis)
    return getWorkerData(site_ref, "scenario_result", redis, {});
  }
}

export async function advance(site_ref, redis, advancer, u) {
  await setU(site_ref, u, redis)
  await advancer.advance([site_ref])
  return await getY(site_ref, redis)
}

export async function stop(site_ref, db, redis, pub) {
  const stat = await getStatus(site_ref, db, redis)
  if (stat == "Running") {
    await setStatus(site_ref, "Stopping", redis)
    sendStopSignal(site_ref, pub)
    await waitForStatus(site_ref, db, redis, "Stopped")
  }
}

export async function getStep(site_ref, db, redis) {
  return new Promise((resolve, reject) => {
    // Look in redis first for a cached value,
    // running tests should have a cached value.
    // Fallback to the testcase default from database
    redis.hget(site_ref, 'step', async (err, res) => {
      if (err) {
        reject(err);
      } else {
        if (res) {
          resolve(res)
        } else {
          try {
            const testcases = db.collection('testcases')
            const query = {site_ref}
            const doc = await testcases.findOne(query)
            resolve(doc.step)
          } catch (e) {
            reject(e)
          }
        }
      }
    })
  })
}

export async function setStep(site_ref, step, db, redis) {
  return new Promise((resolve, reject) => {
    redis.hset(site_ref, 'step', step, async (err) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

export function getKPIs(id, redis) {
  return getWorkerData(id, "kpis", redis, {});
}

export function getResults(id, point_name, start_time, final_time, redis) {
  const params = {point_name, start_time, final_time}
  return getWorkerData(id, "results", redis, params);
}


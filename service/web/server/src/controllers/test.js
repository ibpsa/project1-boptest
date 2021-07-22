import { v4 as uuidv4 } from 'uuid';
import {addJobToQueue} from './job';
import rediscontroller from './redis';
import {
  getS3KeyForTestcaseID
} from './testcase.js';

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

// Given testid, return the testcase id
export function getTestcaseID(testid, redis) {
  return new Promise((resolve, reject) => {
    redis.hget(testid, 'testcaseid', (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
}

export async function getName(testid, redis) {
  // At this time name is equal to testcaseid
  const name = await getTestcaseID(testid, redis)
  return { name }
}

export async function getInputs(testid, db, redis) {
  try {
    const testcaseid = await getTestcaseID(testid, redis)
    const testcases = db.collection('testcases')
    const query = { testcaseid }
    const doc = await testcases.findOne(query, { inputs: 1 })
    return doc.inputs
  } catch(e) {
    console.log(e)
  }
}

export async function getMeasurements(testid, db, redis) {
  try {
    const testcaseid = await getTestcaseID(testid, redis)
    const testcases = db.collection('testcases')
    const query = { testcaseid }
    const doc = await testcases.findOne(query, { measurements: 1 })
    return doc.measurements
  } catch(e) {
    console.log(e)
  }
}

export async function getStatus(testid, db, redis) {
  return await new Promise((resolve, reject) => {
    redis.hexists(testid, 'status', async (existserr, existsdata) => {
      if (existserr) {
          reject(existserr)
      } else {
        if (existsdata) {
          redis.hget(testid, 'status', (err, data) => {
            if (err) {
              reject(err)
            } else {
              resolve(data)
            }
          })
        } else {
          // If testid does not correspond to a redis key,
          // then consider the test stopped, however an Error might make more sense
          resolve("Stopped")
        }
      }
    })
  })
};

export async function waitForStatus(testid, db, redis, desiredStatus, count, maxCount) {
  // The default maxCount is 30, which will result in waiting up to 30 seconds
  maxCount = typeof maxCount !== 'undefined' ? maxCount : 30
  // The default starting count is 0
  count = typeof count !== 'undefined' ? count : 0
  const currentStatus = await getStatus(testid, db, redis);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count >= maxCount) {
    throw(`Timeout waiting for test: ${testid} to reach status: ${desiredStatus}`);
  } else {
    // check status every 1000 miliseconds
    await promiseTaskLater(waitForStatus, 1000, testid, db, redis, desiredStatus, count, maxCount);
    count++
  }
};

export async function setStatus(testid, stat, redis) {
  return await new Promise((resolve, reject) => {
    redis.hset(testid, 'status', stat, (err) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

export async function getForecastParameters(testid, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'get_forecast_parameters', {})
}

export async function setForecastParameters(testid, horizon, interval, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'set_forecast_parameters', { horizon, interval })
}

export async function getForecast(testid, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'get_forecast', {})
}

export async function initialize(testid, params, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'initialize', params)
}

export async function getScenario(testid, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'get_scenario', {})
}

export async function setScenario(testid, scenario, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'set_scenario', { scenario })
}

export async function advance(testid, u, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'advance', { u })
}

export async function stop(testid, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'stop', {})
}

export async function getStep(testid, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'get_step', {})
}

export async function setStep(testid, step, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'set_step', { step })
}

export async function getKPIs(testid, redis, pub, sub) {
  return await rediscontroller.callWorkerMethod(testid, 'get_kpis', {})
}

export async function getResults(testid, point_name, start_time, final_time, redis, pub, sub) {
  const params = {point_name, start_time, final_time}
  return await rediscontroller.callWorkerMethod(testid, 'get_results', params)
}


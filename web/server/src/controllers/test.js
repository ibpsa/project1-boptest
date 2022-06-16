import { v4 as uuidv4 } from 'uuid';
import {addJobToQueue} from './job';
import redis from './redis';
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
export function getTestcaseID(testid) {
  return redis.hget(testid, 'testcaseid')
}

export async function getName(testid) {
  // At this time name is equal to testcaseid
  const name = await getTestcaseID(testid)
  return { name }
}

export async function getInputs(testid, db) {
  try {
    const testcaseid = await getTestcaseID(testid)
    const testcases = db.collection('testcases')
    const query = { testcaseid }
    const doc = await testcases.findOne(query, { inputs: 1 })
    return doc.inputs
  } catch(e) {
    console.log(e)
  }
}

export async function getMeasurements(testid, db) {
  try {
    const testcaseid = await getTestcaseID(testid)
    const testcases = db.collection('testcases')
    const query = { testcaseid }
    const doc = await testcases.findOne(query, { measurements: 1 })
    return doc.measurements
  } catch(e) {
    console.log(e)
  }
}

export async function getStatus(testid) {
  const exists = await redis.hexists(testid, 'status')
  if (exists) {
    return await redis.hget(testid, 'status')
  } else {
    // If testid does not correspond to a redis key,
    // then consider the test stopped, however an Error might make more sense
    return "Stopped"
  }
};

export async function waitForStatus(testid, desiredStatus, count, maxCount) {
  // The default maxCount is 300, which will result in waiting up to 300 seconds
  maxCount = typeof maxCount !== 'undefined' ? maxCount : 300
  // The default starting count is 0
  count = typeof count !== 'undefined' ? count : 0
  const currentStatus = await getStatus(testid);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count >= maxCount) {
    throw(`Timeout waiting for test: ${testid} to reach status: ${desiredStatus}`);
  } else {
    // check status every 1000 miliseconds
    count++
    await promiseTaskLater(waitForStatus, 1000, testid, desiredStatus, count, maxCount);
  }
};

export async function setStatus(testid, stat) {
  return redis.hset(testid, 'status', stat)
}

export async function getForecastParameters(testid) {
  return await redis.callWorkerMethod(testid, 'get_forecast_parameters', {})
}

export async function setForecastParameters(testid, horizon, interval) {
  return await redis.callWorkerMethod(testid, 'set_forecast_parameters', { horizon, interval })
}

export async function getForecast(testid) {
  return await redis.callWorkerMethod(testid, 'get_forecast', {})
}

export async function initialize(testid, params) {
  return await redis.callWorkerMethod(testid, 'initialize', params)
}

export async function getScenario(testid) {
  return await redis.callWorkerMethod(testid, 'get_scenario', {})
}

export async function setScenario(testid, scenario) {
  return await redis.callWorkerMethod(testid, 'set_scenario', { scenario })
}

export async function advance(testid, u) {
  return await redis.callWorkerMethod(testid, 'advance', { u })
}

export async function stop(testid) {
  return await redis.callWorkerMethod(testid, 'stop', {})
}

export async function getStep(testid) {
  return await redis.callWorkerMethod(testid, 'get_step', {})
}

export async function setStep(testid, step) {
  return await redis.callWorkerMethod(testid, 'set_step', { step })
}

export async function getKPIs(testid) {
  return await redis.callWorkerMethod(testid, 'get_kpis', {})
}

export async function getResults(testid, point_name, start_time, final_time) {
  const params = {point_name, start_time, final_time}
  return await redis.callWorkerMethod(testid, 'get_results', params)
}


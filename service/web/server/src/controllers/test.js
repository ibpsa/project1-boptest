import { v4 as uuidv4 } from 'uuid';
import {addJobToQueue} from './job';
import messaging from './messaging';
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
  return messaging.hget(testid, 'testcaseid')
}

// Given testid, return the 1 if it exists
export function checkTestIDExists(testid, userid) {
  userid = typeof userid !== 'undefined' ? userid : 'undefined'; // If userID is undefined, set it to undefined string
  const rediskey = 'users:' + userid +':tests'
  return messaging.hexists(rediskey, testid)
}

// Get all public tests
export async function getTests(userid) {
  // userid = typeof userid !== 'undefined' ? userid : 'shared';
  const exists = await messaging.hlen('users:'+userid+':tests')
  if (exists) {
    const tests =  await messaging.hkeys('users:'+userid+':tests');
    const tests_string = []
    tests.forEach(element => {
      tests_string.push(Buffer.from(element).toString())
    });
    return JSON.stringify(tests_string)
  } else {
    // If testid does not correspond to a redis key,
    // then consider the test stopped, however an Error might make more sense
    return "No tests available"
  }
}

export async function getName(testid) {
  return await messaging.callWorkerMethod(testid, 'get_name', {})
}

export async function getInputs(testid, db) {
  return await messaging.callWorkerMethod(testid, 'get_inputs', {})
}

export async function getMeasurements(testid, db) {
  return await messaging.callWorkerMethod(testid, 'get_measurements', {})
}

export async function getStatus(rediskey, testid) {
  const exists = await messaging.hexists(rediskey, testid)
  if (exists) {
    const metadata_string =  await messaging.hget(rediskey, testid)
    return (JSON.parse(metadata_string)).status
  } else {
    // If testid does not correspond to a redis key,
    // then consider the test stopped, however an Error might make more sense
    return "Stopped"
  }
};

export async function waitForStatus(rediskey, testid, desiredStatus, count, maxCount) {
  maxCount = typeof maxCount !== 'undefined' ? maxCount : process.env.SERVICE_TIMEOUT
  // The default starting count is 0
  count = typeof count !== 'undefined' ? count : 0
  const currentStatus = await getStatus(rediskey, testid);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count >= maxCount) {
    throw(`Timeout waiting for test: ${testid} to reach status: ${desiredStatus}`);
  } else {
    // check status every 1000 miliseconds
    await promiseTaskLater(waitForStatus, 1000, rediskey, testid, desiredStatus, count, maxCount);
    count++
  }
};

export async function setStatus(rediskey, testid, stat) {
  return messaging.hset(rediskey, testid, JSON.stringify(stat))
}

export async function getForecastParameters(testid) {
  return await messaging.callWorkerMethod(testid, 'get_forecast_parameters', {})
}

export async function setForecastParameters(testid, horizon, interval) {
  return await messaging.callWorkerMethod(testid, 'set_forecast_parameters', { horizon, interval })
}

export async function getForecast(testid) {
  return await messaging.callWorkerMethod(testid, 'get_forecast', {})
}

export async function initialize(testid, params) {
  return await messaging.callWorkerMethod(testid, 'initialize', params)
}

export async function getScenario(testid) {
  return await messaging.callWorkerMethod(testid, 'get_scenario', {})
}

export async function setScenario(testid, scenario) {
  return await messaging.callWorkerMethod(testid, 'set_scenario', { scenario })
}

export async function advance(testid, u) {
  return await messaging.callWorkerMethod(testid, 'advance', { u })
}

export async function stop(testid) {
  return await messaging.callWorkerMethod(testid, 'stop', {})
}

export async function getStep(testid) {
  return await messaging.callWorkerMethod(testid, 'get_step', {})
}

export async function setStep(testid, step) {
  return await messaging.callWorkerMethod(testid, 'set_step', { step })
}

export async function getKPIs(testid) {
  return await messaging.callWorkerMethod(testid, 'get_kpis', {})
}

export async function getResults(testid, point_name, start_time, final_time) {
  const params = {point_name, start_time, final_time}
  return await messaging.callWorkerMethod(testid, 'get_results', params)
}

export async function submit(testid, api_key, tags, unit_test) {
  const params = {api_key, tags, unit_test}
  return await messaging.callWorkerMethod(testid, 'post_results_to_dashboard', params)
}

import Path from 'path';
import { promises as fs } from "fs";
import { v4 as uuidv4 } from 'uuid';
import s3 from '../s3';
import {addJobToQueue} from './job';
import messaging from './messaging';

const bucket = process.env.BOPTEST_S3_BUCKET

export function getPrefixForTestcase(testcaseNamespace) {
  return `testcases/${testcaseNamespace}`
}
export function getPrefixForUserTestcase(userDis) {
  return `users/${userDis}/testcases`
}

export function getKeyForTestcase(testcaseNamespace, testcaseID) {
  return `${getPrefixForTestcase(testcaseNamespace)}/${testcaseID}/${testcaseID}.fmu`
}

export function getKeyForUserTestcase(userDis, testcaseID) {
  return `${getPrefixForUserTestcase(userDis)}/${testcaseID}/${testcaseID}.fmu`
}

// All tests are added to an in memory (e.g redis) hash,
// under the key returned by this function.
// See docs/redis.md
function getUserTestsStatusKey(userDis) {
  // userDis could be undefined in which case the key will still be valid.
  // e.g. "users:undefined:tests:${testDis}"
  // This would be true when a test is selected by a client that is not logged in
  return `users:${userDis}:tests:status`
}

export async function getVersion() {
  const libraryVersion = (await fs.readFile('/boptest/version.txt', 'utf8')).trim()
  const serviceVersion = (await fs.readFile('/boptest/service-version.txt', 'utf8')).trim()
  
  const status = 200;
  const message = "Queried the version number successfully."
  const payload = {'version': libraryVersion, 'service-version': serviceVersion}
  return {status, message, payload}
}

function promiseTaskLater(task, time, ...args) {
  return new Promise((resolve, reject) => {
    setTimeout(async () => {
      try {
        await task(...args)
        resolve()
      } catch (e) {
        reject(e)
      }
    }, time)
  })
}

export function getTestcasePostForm(testcaseKey, s3url) {
  return new Promise((resolve, reject) => {
    // Construct a new postPolicy.
    const params = {
      Bucket: bucket,
      Fields: {
        key: testcaseKey
      }
    }
    
    s3.createPresignedPost(params, function(err, data) {
      if (err) {
        reject(err)
      } else {
        if (s3url) {
          data.url = s3url
        }
        resolve(data)
      }
    })
  })
}

export function getTestcases(prefix) {
  return new Promise((resolve, reject) => {
    const params = {
      Bucket: bucket,
      Prefix: prefix
    }

    s3.listObjectsV2(params, function(err, data) {
      if (err) {
        reject(err)
      } else {
        const result = data.Contents.map(item => ({ testcaseid: Path.parse(item.Key).name }));
        resolve(result)
      }
    })
  })
}

export async function isTestcase(prefix, testcaseID) {
  const testcases = await getTestcases(prefix)
  return (testcases.find(item => item.testcaseid == testcaseID)) != undefined
}

export function deleteTestcase(testcaseKey) {
  return new Promise((resolve, reject) => {
    const params = {
      Bucket: bucket,
      Key: testcaseKey
    }

    s3.deleteObject(params, function(err, data) {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

export async function select(testcaseKey, userDis) {
  const testid = uuidv4()
  await enqueueTest(testid, userDis, testcaseKey)
  await waitForStatus(userDis, testid, "Running")
  return { testid }
}

export async function enqueueTest(testid, userDis, testcaseKey) {
  const userTestsKey = getUserTestsStatusKey(userDis)
  await messaging.hset(userTestsKey, testid, "Queued")
  await addJobToQueue("boptest_run_test", {testid, userTestsKey, testcaseKey})
}

// Determine if testid exists for user
export async function isTest(userDis, testid) {
  const userTestsKey = getUserTestsStatusKey(userDis)
  return await messaging.hexists(userTestsKey, testid)
}

export async function getStatus(userDis, testid) {
  const exists = await isTest(userDis, testid)
  if (exists) {
    const userTestsKey = getUserTestsStatusKey(userDis)
    return await messaging.hget(userTestsKey, testid)
  } else {
    // If testid does not correspond to a redis key,
    // then consider the test stopped, however an Error might make more sense
    throw(`Cannot getStatus for testid ${testid} and user ${userDis} because it does not exist`);
  }
}

export async function waitForStatus(userDis, testid, desiredStatus, count, maxCount) {
  maxCount = typeof maxCount !== 'undefined' ? maxCount : process.env.BOPTEST_TIMEOUT
  // The default starting count is 0
  count = typeof count !== 'undefined' ? count : 0
  const currentStatus = await getStatus(userDis, testid);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count >= maxCount) {
    throw(`Timeout waiting for test: ${testid} to reach status: ${desiredStatus}`);
  } else {
    // check status every 1000 miliseconds
    await promiseTaskLater(waitForStatus, 1000, userDis, testid, desiredStatus, count, maxCount);
    count++
  }
}

// Given testid, return the testcase id
export async function getTests(userDis) {
  const userTestsKey = getUserTestsStatusKey(userDis)
  // TODO use select instead
  const redisdata = await messaging.hgetall(userTestsKey)
  // This is a workaround, because we use "return_buffers" option on the redis client
  // We are doing that due to a limiation of the worker being stuck on python2.x
  let response = {}
  for (let key in redisdata) {
    response[key] = redisdata[key].toString()
  }
  return response
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

import Path from 'path';
import { promises as fs } from "fs";
import { v4 as uuidv4 } from 'uuid';
import redis from '../redis';
import s3 from '../s3';
import { addJobToQueue } from './job';
import messaging from './messaging';

const bucket = process.env.BOPTEST_S3_BUCKET

// Keys to track test cases
// These are used as keys for object storage (e.g. S3)
// See docs/file_storage.md

export function getPrefixForTestcase(testcaseNamespace) {
  return `testcases/${testcaseNamespace}`
}

export function getPrefixForUserTestcase(userSub) {
  return `users/${userSub}/testcases`
}

export function getKeyForTestcase(testcaseNamespace, testcaseID) {
  return `${getPrefixForTestcase(testcaseNamespace)}/${testcaseID}/${testcaseID}.fmu`
}

export function getKeyForUserTestcase(userSub, testcaseID) {
  return `${getPrefixForUserTestcase(userSub)}/${testcaseID}/${testcaseID}.fmu`
}

// Keys for tests
// These are used as keys for in memory key/value storage (e.g. Redis)
// See docs/redis.md

function getTestKey(testid) {
  return `tests:${testid}`
}

function getUserTestsKey(userSub) {
  return `users:${userSub}:tests`
}

// BOPTEST functions

export async function getVersion() {
  const libraryVersion = (await fs.readFile('/boptest/version.txt', 'utf8')).trim()
  const serviceVersion = (await fs.readFile('/boptest/service-version.txt', 'utf8')).trim()

  const status = 200;
  const message = "Queried the version number successfully."
  const payload = { 'version': libraryVersion, 'service-version': serviceVersion }
  return { status, message, payload }
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

export function getTestcasePostForm(testcaseKey, s3url, share) {
  return new Promise((resolve, reject) => {
    // Construct a new postPolicy.
    let params = {
      Bucket: bucket,
      Fields: {
        key: testcaseKey
      }
    }

    if (share) {
      // minio does not support object level ACL, therefore ExtraArgs will only apply to s3 configurations
      params.Fields.acl = "public-read"
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

async function addTestToDB(testid, userSub) {
  const testKey = getTestKey(testid)
  await redis.hset(testKey, "status", "Queued")
  await redis.hset(testKey, "timestamp", Date.now())
  if (userSub) {
    const userTestsKey = getUserTestsKey(userSub)
    await redis.hset(testKey, "user", userSub)
    await redis.sadd(userTestsKey, testid)
  }
}

async function removeTestFromDB(testid) {
  const testKey = getTestKey(testid)
  const userSub = await redis.hget(testKey, "user")
  if (userSub) {
    const userTestsKey = getUserTestsKey(userSub)
    await redis.srem(userTestsKey, testid)
  }
  await redis.del(testKey)
}

export async function select(testcaseKey, userSub, asyc) {
  const testid = uuidv4()
  await addTestToDB(testid, userSub)
  const testKey = getTestKey(testid)
  await addJobToQueue("boptest_run_test", { testid, testcaseKey })
  if (!asyc) {
    try {
      await waitForStatus(testid, "Running")
    } catch (e) {
      await stop(testid)
      // rethrow the error after stopping the test
      throw e
    }
  }
  return { testid }
}

export async function isTest(testid) {
  const testKey = getTestKey(testid)
  return await redis.hexists(testKey, "status")
}

export async function getStatus(testid) {
  const exists = await isTest(testid)
  if (exists) {
    const testKey = getTestKey(testid)
    const status = await redis.hget(testKey, "status")
    return status.toString()
  } else {
    throw (`Cannot getStatus for testid ${testid}, because it does not exist`);
  }
}

export async function waitForStatus(testid, desiredStatus, count, maxCount) {
  maxCount = typeof maxCount !== 'undefined' ? maxCount : process.env.BOPTEST_TIMEOUT
  // The default starting count is 0
  count = typeof count !== 'undefined' ? count : 0
  const currentStatus = await getStatus(testid);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count >= maxCount) {
    throw (`Timeout waiting for test: ${testid} to reach status: ${desiredStatus}`);
  } else {
    // check status every 1000 miliseconds
    await promiseTaskLater(waitForStatus, 1000, testid, desiredStatus, count, maxCount);
    count++
  }
}

// Given testid, return the testcase id
export async function getTests(userSub) {
  const userTestsKey = getUserTestsKey(userSub)
  let userTests = []
  let items = []
  let curser = 0
  do {
    [curser, items] = await redis.sscan(userTestsKey, curser)
    for (const i in items) {
      userTests.push(items[i].toString())
    }
  } while (curser != 0)
  return userTests
}

export async function stop(testid) {
  const status = await getStatus(testid)
  // If the test is not running it is Queued, in which case
  // we don't technically remove it from the queue, but removing the entry in the db
  // will cause the worker to immediately move on when the test comes off the queue
  await removeTestFromDB(testid)
  if (status == "Running") {
    // In this case send a stop message to the worker,
    // The worker will also attempt to remove the test from db, but it should already be removed
    messaging.callWorkerMethod(testid, 'stop', {}).catch(err => {
      // If the worker has disappeared, then the message could timeout.
      // The client has already received a response so just log the error.
      console.log(err.stack)
    })
  }
}

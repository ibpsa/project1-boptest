import s3 from '../s3';
import { v4 as uuidv4 } from 'uuid';
import {addJobToQueue} from './job';
import {
  enqueueTest,
  waitForStatus
} from './test';
import Path from 'path';

const bucket = process.env.BOPTEST_S3_BUCKET

export function getPrefixForTestcase(testcaseNamespace) {
  return `testcases/${testcaseNamespace}`
}
export function getPrefixForUserTestcase(userName) {
  return `users/${userName}/testcases`
}

export function getKeyForTestcase(testcaseNamespace, testcaseID) {
  return `${getPrefixForTestcase(testcaseNamespace)}/${testcaseID}/${testcaseID}.fmu`
}

export function getKeyForUserTestcase(userName, testcaseID) {
  return `${getPrefixForUserTestcase(userName)}/${testcaseID}/${testcaseID}.fmu`
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

export async function select(testcaseKey, username) {
  const testid = uuidv4()
  await enqueueTest(testid, username, testcaseKey)
  await waitForStatus(username, testid, "Running")
  return { testid }
}

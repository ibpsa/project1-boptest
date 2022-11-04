import s3 from '../s3';
import { v4 as uuidv4 } from 'uuid';
import {addJobToQueue} from './job';
import {
  setStatus,
  waitForStatus
} from './test';
import Path from 'path';

export function getS3KeyForTestcaseID(testcaseid, userid) {
  let prefix = 'shared'
  if (userid) {
    prefix = userid
  }
  return `testcases/${prefix}/${testcaseid}/${testcaseid}.fmu`
}

export function getTestcasePostForm(testcaseid, s3url, userid) {
  return new Promise((resolve, reject) => {
    // Construct a new postPolicy.
    const params = {
      Bucket: process.env.S3_BUCKET,
      Fields: {
        key: getS3KeyForTestcaseID(testcaseid, userid)
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

export async function getTestcases(userid) {
  const testcasesForPrefix = (prefix) => {
    return new Promise((resolve, reject) => {
      const params = {
        Bucket: process.env.S3_BUCKET,
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

  if (userid) {
    return await testcasesForPrefix(`testcases/${userid}`)
  } else {
    return await testcasesForPrefix('testcases/shared')
  }
}

export async function isTestcase(id, userid) {
  const testcases = await getTestcases(userid)
  const found = testcases.find( t => t.testcaseid == id )
  return found != undefined
}

export async function select(testcaseid, userid) {
  const testid = uuidv4()
  const key = getS3KeyForTestcaseID(testcaseid, userid)
  await setStatus(testid, "Starting")
  await addJobToQueue("boptest_run_test", {testcaseid, testid, key})
  await waitForStatus(testid, "Running")
  return { testid }
}

export async function removeTestcase(id, userid) {
  const key = getS3KeyForTestcaseID(id, userid)

  await new Promise((resolve, reject) => {
    const params = {
      Bucket: process.env.S3_BUCKET,
      Key: key
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

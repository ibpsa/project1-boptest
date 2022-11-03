import s3 from '../s3';
import { v4 as uuidv4 } from 'uuid';
import {addJobToQueue} from './job';
import {
  setStatus,
  waitForStatus
} from './test';
import Path from 'path';

export function getS3KeyForTestcaseID(testcaseid) {
  return `testcases/shared/${testcaseid}/${testcaseid}.fmu`
}

export function getTestcasePostForm(testcaseid, s3url) {
  return new Promise((resolve, reject) => {
    // Construct a new postPolicy.
    const params = {
      Bucket: process.env.S3_BUCKET,
      Fields: {
        key: getS3KeyForTestcaseID(testcaseid)
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

export async function getTestcases() {
  return new Promise((resolve, reject) => {
    const params = {
      Bucket: process.env.S3_BUCKET,
      Prefix: "testcases/shared"
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

export async function isTestcase(id) {
  const testcases = await getTestcases()
  const found = testcases.find( t => t.testcaseid == id )
  return found != undefined
}

export async function select(testcaseid, api_key) {
  const testid = uuidv4()
  const key = getS3KeyForTestcaseID(testcaseid)
  await setStatus(testid, "Starting")
  await addJobToQueue("boptest_run_test", {testcaseid, testid, key, api_key})
  await waitForStatus(testid, "Running")
  return { testid }
}

export async function removeTestcase(id) {
  const key = getS3KeyForTestcaseID(id)

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

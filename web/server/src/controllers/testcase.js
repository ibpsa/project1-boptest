import { v4 as uuidv4 } from 'uuid';
import {addJobToQueue} from './job';
import {
  setStatus,
  waitForStatus
} from './test';

export function getS3KeyForTestcaseID(testcaseid) {
  return `testcases/${testcaseid}/${testcaseid}.fmu`
}

export async function createOrUpdateTestcase(testcaseid, sqs) {
  const params = {
    'key': getS3KeyForTestcaseID(testcaseid),
    'testcaseid': testcaseid
  }

  await addJobToQueue("boptest_add_testcase", params, sqs);
}

export function getTestcasePostForm(testcaseid, s3, s3url) {
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

export async function getTestcases(db) {
  const testcases = db.collection('testcases')
  const query = {}
  const options = {
    projection: {
      _id: 0,
      testcaseid: 1
    }
  }
  const ids = await testcases.find(query, options).toArray()
  return ids
}

export async function isTestcase(id, db) {
  const testcases = await getTestcases(db)
  const found = testcases.find( t => t.testcaseid == id )
  return found != undefined
}

export async function select(testcaseid, sqs, api_key) {
  const testid = uuidv4()
  const key = getS3KeyForTestcaseID(testcaseid)
  await setStatus(testid, "Starting")
  await addJobToQueue("boptest_run_test", {testcaseid, testid, key, api_key}, sqs)
  await waitForStatus(testid, "Running")
  return { testid }
}

import {addJobToQueue} from './job';

export function getS3KeyForTestcaseID(testcaseid) {
  return `testcases/${testcaseid}/${testcaseid}.fmu`
}

export async function createOrUpdateTestcase(testcaseid, sqs) {
  const args = {
    'key': getS3KeyForTestcaseID(testcaseid),
    'testcaseid': testcaseid
  }

  await addJobToQueue("addSite", args, sqs);
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

export async function getInputs(testcaseid, db) {
  try {
    const testcases = db.collection('testcases')
    const query = { testcaseid }
    const doc = await testcases.findOne(query, { inputs: 1 })
    return doc.inputs
  } catch(e) {
    console.log(e)
  }
}

export async function getMeasurements(testcaseid, db) {
  try {
    const testcases = db.collection('testcases')
    const query = { testcaseid }
    const doc = await testcases.findOne(query, { measurements: 1 })
    return doc.measurements
  } catch(e) {
    console.log(e)
  }
}

export async function getName(testcaseid, db) {
  try {
    const testcases = db.collection('testcases')
    const query = { testcaseid }
    const doc = await testcases.findOne(query, { testcaseid: 1 })
    const name = doc.testcaseid
    return {name}
  } catch(e) {
    console.log(e)
  }
}

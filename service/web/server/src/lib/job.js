import sqs from '../sqs'

export async function addJobToQueue(jobtype, params) {
  return new Promise((resolve, reject) => {
    let body = {
      jobtype,
      params
    }

    const m = {
      MessageBody: JSON.stringify(body),
      QueueUrl: process.env.BOPTEST_JOB_QUEUE_URL,
      MessageGroupId: "Alfalfa"
    }

    sqs.sendMessage(m, (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}


export function addJobToQueue(jobtype, params, sqs) {
  return new Promise((resolve, reject) => {
    let body = {
      jobtype,
      params
    }

    const m = {
      MessageBody: JSON.stringify(body),
      QueueUrl: process.env.JOB_QUEUE_URL,
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

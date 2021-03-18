
export function addJobToQueue(jobName, sqs, args) {
  return new Promise((resolve, reject) => {
    let body = {
      "op": "InvokeAction",
      "action": jobName
    }

    Object.entries(args).forEach(([key,value]) => {
      body[key] = value
    })

    const params = {
      MessageBody: JSON.stringify(body),
      QueueUrl: process.env.JOB_QUEUE_URL,
      MessageGroupId: "Alfalfa"
    }

    sqs.sendMessage(params, (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

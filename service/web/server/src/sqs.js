import AWS from 'aws-sdk'

AWS.config.update({ region: process.env.REGION })
const sqs = new AWS.SQS()
export default sqs

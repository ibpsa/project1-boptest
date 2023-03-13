import AWS from 'aws-sdk'

AWS.config.update({ region: process.env.BOPTEST_REGION })
const sqs = new AWS.SQS()
export default sqs

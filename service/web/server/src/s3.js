import AWS from 'aws-sdk'

AWS.config.update({ region: process.env.BOPTEST_REGION })
const s3 = new AWS.S3({ endpoint: process.env.BOPTEST_INTERNAL_S3_URL, s3ForcePathStyle: true })
export default s3

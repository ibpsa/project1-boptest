import AWS from 'aws-sdk'

AWS.config.update({ region: process.env.REGION })
const s3 = new AWS.S3({ endpoint: process.env.S3_URL, s3ForcePathStyle: true })
export default s3

import express from 'express'
import bodyParser from 'body-parser'
import AWS from 'aws-sdk'
import publicRoutes from './routes/public'
import authorizedRoutes from './routes/authorized'

AWS.config.update({ region: process.env.REGION })
const s3 = new AWS.S3({ endpoint: process.env.S3_URL, s3ForcePathStyle: true })
const sqs = new AWS.SQS()

var app = express()

app.set('sqs', sqs)
app.set('s3', s3)

app.use(bodyParser.urlencoded())
app.use(bodyParser.json())
app.use('/', publicRoutes)
app.use('/', authorizedRoutes)

let server = app.listen(80, () => {
  var host = server.address().address
  var port = server.address().port

  if (host.length === 0 || host === "::") host = "localhost"
  console.log('Server listening at http://%s:%s', host, port)
})

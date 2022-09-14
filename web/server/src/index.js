import express from 'express'
import bodyParser from 'body-parser'
import {MongoClient} from 'mongodb'
import AWS from 'aws-sdk'
import boptestRouter from './routes/boptest'
import boptestAdminRouter from './routes/boptest-admin'

AWS.config.update({ region: process.env.REGION })
const s3 = new AWS.S3({ endpoint: process.env.S3_URL, s3ForcePathStyle: true })
const sqs = new AWS.SQS()

MongoClient.connect(process.env.MONGO_URL).then((mongoClient) => {
  var app = express()

  const db = mongoClient.db(process.env.MONGO_DB_NAME)

  app.set('db', db)
  app.set('sqs', sqs)
  app.set('s3', s3)

  app.use(bodyParser.urlencoded())
  app.use(bodyParser.json())
  app.use('/', boptestRouter)
  app.use('/', boptestAdminRouter)

  let server = app.listen(80, () => {
    var host = server.address().address
    var port = server.address().port

    if (host.length === 0 || host === "::") host = "localhost"
    console.log('Server listening at http://%s:%s', host, port)
  })
}).catch((err) => {
  console.log(err)
})

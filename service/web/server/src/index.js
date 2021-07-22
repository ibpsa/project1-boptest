import express from 'express'
import bodyParser from 'body-parser'
import {MongoClient} from 'mongodb'
import node_redis from 'redis'
import AWS from 'aws-sdk'
import boptestRouter from './routes/boptest'
import boptestAdminRouter from './routes/boptest-admin'
import errorHandler from './routes/error'
import redis from './controllers/redis'

AWS.config.update({ region: process.env.REGION })
const s3 = new AWS.S3({ endpoint: process.env.S3_URL })
const sqs = new AWS.SQS()
//const redis = node_redis.createClient({host: process.env.REDIS_HOST})
//const pub = redis.duplicate()
//const sub = redis.duplicate()

//function errorHandler(err, req, res, next) {
//  if (err.mapped) {
//    res.status(400).send(err.mapped())
//  } else {
//    next(err)
//  }
//}

MongoClient.connect(process.env.MONGO_URL).then((mongoClient) => {
  var app = express()

  const db = mongoClient.db(process.env.MONGO_DB_NAME)

  app.set('redis', redis.client)
  app.set('pub', redis.pubclient)
  app.set('sub', redis.subclient)
  app.set('db', db)
  app.set('sqs', sqs)
  app.set('s3', s3)

  app.use(bodyParser.text({ type: 'text/*' }))
  app.use(bodyParser.urlencoded())
  app.use(bodyParser.json())
  app.use('/', boptestRouter)
  app.use('/', boptestAdminRouter)
  app.use(errorHandler)

  let server = app.listen(80, () => {
    var host = server.address().address
    var port = server.address().port

    if (host.length === 0 || host === "::") host = "localhost"
    console.log('Server listening at http://%s:%s', host, port)
  })
}).catch((err) => {
  console.log(err)
})

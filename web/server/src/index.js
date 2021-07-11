/***********************************************************************************************************************
*  Copyright (c) 2008-2018, Alliance for Sustainable Energy, LLC, and other contributors. All rights reserved.
*
*  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
*  following conditions are met:
*
*  (1) Redistributions of source code must retain the above copyright notice, this list of conditions and the following
*  disclaimer.
*
*  (2) Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
*  disclaimer in the documentation and/or other materials provided with the distribution.
*
*  (3) Neither the name of the copyright holder nor the names of any contributors may be used to endorse or promote products
*  derived from this software without specific prior written permission from the respective party.
*
*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) AND ANY CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
*  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
*  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER(S), ANY CONTRIBUTORS, THE UNITED STATES GOVERNMENT, OR THE UNITED
*  STATES DEPARTMENT OF ENERGY, NOR ANY OF THEIR EMPLOYEES, BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
*  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
*  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
*  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
*  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
***********************************************************************************************************************/

import path from 'path';
import hs from 'nodehaystack';
import express from 'express';
import url from 'url';
import bodyParser from 'body-parser';
import {MongoClient} from 'mongodb';
import node_redis from 'redis';
import { URL } from "url";
import AWS from 'aws-sdk';
import boptestRouter from './routes/boptest';
import boptestAdminRouter from './routes/boptest-admin';
import {Advancer} from './advancer';

AWS.config.update({ region: process.env.REGION });
const client = new AWS.S3({ endpoint: process.env.S3_URL });
const sqs = new AWS.SQS();
const redis = node_redis.createClient({host: process.env.REDIS_HOST});
const pub = redis.duplicate();
const sub = redis.duplicate();
const advancer = new Advancer(redis, pub, sub);

MongoClient.connect(process.env.MONGO_URL).then((mongoClient) => {
  var app = express();

  const db = mongoClient.db(process.env.MONGO_DB_NAME);

  app.set('redis', redis);
  app.set('pub', pub);
  app.set('db', db);
  app.set('sqs', sqs);
  app.set('s3', client);
  app.set('advancer', advancer);

  app.use(bodyParser.text({ type: 'text/*' }));
  app.use(bodyParser.urlencoded())
  app.use(bodyParser.json());
  app.use('/', boptestRouter)
  app.use('/', boptestAdminRouter)

  let server = app.listen(80, () => {
    var host = server.address().address;
    var port = server.address().port;

    if (host.length === 0 || host === "::") host = "localhost";
    console.log('Server listening at http://%s:%s', host, port);
  });
}).catch((err) => {
  console.log(err);
});

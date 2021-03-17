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

// Module dependencies.
import path from 'path';
import hs from 'nodehaystack';
import express from 'express';
import url from 'url';
import bodyParser from 'body-parser';
import {MongoClient} from 'mongodb';
import node_redis from 'redis';
import graphQLHTTP from 'express-graphql';
import {Schema} from './schema';
import boptestRoutes from './routes/boptest-routes.js';
import {Advancer} from './advancer';
import historyApiFallback from 'connect-history-api-fallback';
import morgan from 'morgan';
import { URL } from "url";
import AWS from 'aws-sdk';

var client = new AWS.S3({endpoint: process.env.S3_URL});

const redis = node_redis.createClient({host: process.env.REDIS_HOST});
const pub = redis.duplicate();
const sub = redis.duplicate();
const advancer = new Advancer(redis, pub, sub);

MongoClient.connect(process.env.MONGO_URL).then((mongoClient) => {
  var app = express();

  if( process.env.NODE_ENV == "production" ) {
    app.get('*.js', function(req, res, next) {
      req.url = req.url + '.gz';
      res.set('Content-Encoding', 'gzip');
      res.set('Content-Type', 'text/javascript');
      next();
    });

    app.get('*.css', function(req, res, next) {
      req.url = req.url + '.gz';
      res.set('Content-Encoding', 'gzip');
      res.set('Content-Type', 'text/css');
      next();
    });
  } else {
    app.use(morgan('combined'))
  }

  const db = mongoClient.db(process.env.MONGO_DB_NAME);

  app.set('redis', redis);
  app.set('db', db);

  app.use('/graphql', (request, response) => {
      return graphQLHTTP({
        graphiql: true,
        pretty: true,
        schema: Schema,
        context: {
          ...request,
          db,
          advancer,
          redis,
          pub,
          sub
        }
      })(request,response)
    }
  );

  app.use(bodyParser.text({ type: 'text/*' }));
  app.use(bodyParser.urlencoded())
  app.use(bodyParser.json()); // if you are using JSON instead of ZINC you need this
  app.use('/', boptestRoutes)

  // Create a post url for file uploads
  // from a browser
  app.post('/upload-url', (req, res) => {
    // Construct a new postPolicy.
    const params = {
      Bucket: process.env.S3_BUCKET,
      Fields: {
        key: req.body.name
      }
    };

    client.createPresignedPost(params, function(err, data) {
      if (err) {
        throw err;
      } else {
        if ( process.env.S3_URL.indexOf("amazonaws") == -1 ) {
          if (req.hostname.indexOf("web") == -1 ) {
            const url = 'http://' + req.hostname + ':9000/' + process.env.S3_BUCKET;
            data.url = url;
          } else {
            const url = 'http://minio:9000/alfalfa';
            data.url = url;
          }
        }
        res.send(JSON.stringify(data));
        res.end();
        return;
      }
    });
  });

  app.use(historyApiFallback());
  app.use('/', express.static(path.join(__dirname, './app')));

  let server = app.listen(80, () => {

    var host = server.address().address;
    var port = server.address().port;

    if (host.length === 0 || host === "::") host = "localhost";

    console.log('Node Haystack Toolkit listening at http://%s:%s', host, port);

  });
}).catch((err) => {
  console.log(err);
});

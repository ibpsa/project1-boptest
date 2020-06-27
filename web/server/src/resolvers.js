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

import AWS from 'aws-sdk';
import request from 'superagent';
import {MongoClient} from 'mongodb';
import path from 'path';
import dbops from './dbops';

AWS.config.update({region: process.env.REGION});
var sqs = new AWS.SQS();
var s3client = new AWS.S3({endpoint: process.env.S3_URL});

function addJobToQueue(jobName, args) {
  let body = {
    "op": "InvokeAction",
    "action": jobName
  };

  Object.entries(args).forEach(([key,value]) => {
    body[key] = value;
  });
  
  const params = {
   MessageBody: JSON.stringify(body),
   QueueUrl: process.env.JOB_QUEUE_URL,
   MessageGroupId: "Alfalfa"
  };
  
  sqs.sendMessage(params, (err, data) => {
    if (err) {
      console.log(err);
    }
  });
}

function addSiteResolver(args, context) {
  addJobToQueue("addSite", args);
}

function runSiteResolver(args, context) {
  const updateStatus = () => {
    const recs = context.db.collection('recs');
    return recs.updateOne(
      { _id: args.siteRef },
      { $set: { "rec.simStatus": "s:Starting" } }
    );
  };

  updateStatus().then(addJobToQueue("runSite", args));
}

function stopSiteResolver(args, context) {
  const recs = context.db.collection('recs');
  recs.updateOne(
    { _id: args.siteRef },
    { $set: { "rec.simStatus": "s:Stopping" } }
  ).then( () => {
    context.pub.publish(args.siteRef, "stop");
  });
}

function removeSiteResolver(args, context) {
  const recs = context.db.collection('recs');
  const writearrays = context.db.collection('writearrays');

  recs.deleteMany({site_ref: args.siteRef});
  writearrays.deleteMany({siteRef: args.siteRef});
}

function simsResolver(user,args,context) {
  return new Promise( (resolve,reject) => {
      let sims = [];
      const simcollection = context.db.collection('sims');
      simcollection.find(args).toArray().then((array) => {
        array.map( (sim) => {
          sim = (Object.assign(sim, {"simRef": sim._id}));
          if ( sim.s3Key ) {
            var params = {Bucket: process.env.S3_BUCKET, Key: sim.s3Key, Expires: 86400};
            var url = s3client.getSignedUrl('getObject', params);
            sim = (Object.assign(sim, {"url": url}));
          }
          sims.push(sim)
        })
        resolve(sims);
      }).catch((err) => {
        reject(err);
      });
    });
};

function  sitesResolver(args, context) {
  const removePrefix = (s) => {
    if(s) {
      return s.replace(/[a-z]\:/,'')
    } else {
      return undefined;
    }
  }
  return new Promise((resolve, reject) => {
    const recs = context.db.collection('recs');
    let query = {"rec.site": "m:"};
    if(args.siteRef) {
      query["site_ref"] = args.siteRef;
    }
    recs.find(query).toArray().then((array) => {
      let sites = [];
      array.map( (s) => {
        const datetime = removePrefix(s.rec['datetime']);
        const step = removePrefix(s.rec['step']);
        let site = {
          name: removePrefix(s.rec.dis),
          siteRef: removePrefix(s.rec.siteRef),
          simStatus: removePrefix(s.rec.simStatus),
          simType: removePrefix(s.rec.simType),
          datetime,
          step
        };
        sites.push(site);
      });
      resolve(sites)
    }).catch((err) => {
      reject(err);
    });
  });
}

function sitePointResolver(siteRef, args, context) {
  return new Promise((resolve, reject) => {
    const recs = context.db.collection('recs');
    let query = {site_ref: siteRef, "rec.point": "m:"};
    if (args.writable) {query["rec.writable"] = "m:"};
    if (args.cur) {query["rec.cur"] = "m:"};
    recs.find(query).toArray().then((array) => {
      let points = [];
      array.map( (rec) => {
        let point = {};
        point.tags = [];
        point.dis = rec.rec.dis
        for (const reckey in rec.rec) {
            const tag = {key: reckey, value: rec.rec[reckey]};
            point.tags.push(tag);
        }
        points.push(point);
      });
      resolve(points)
    }).catch((err) => {
      reject(err);
    });
  });
}

function forecastsResolver(site, args, context) {
  return new Promise((resolve, reject) => {

    const makeForecast = (metric, values) => {
      return {metric, values};
    };

    context.redis.hget(site.siteRef, 'forecast', (err, stringdata) => {
      let forecasts = [];

      if( err ) {
          resolve(forecasts);
      }

      const data = JSON.parse(stringdata);
      if( args.metric ) {
        const values = data[args.metric];
        if( values ) {
          forecasts.push(makeForecast(args.metric, values));
        }
      } else {
        Object.entries(data).forEach(([metric,values]) => {
          forecasts.push(makeForecast(metric, values));
        });
      }

      resolve(forecasts);
    });
  });
}

function advanceResolver(advancer, siteRef) {
  return advancer.advance(siteRef);
}

function writePointResolver(context,siteRef, pointName, value, level) {
  return dbops.getPoint(siteRef, pointName, context.db).then( point => {
    return dbops.writePoint(point._id, siteRef, level, value, null, null, context.db);
  }).then( array => {
    return array;
  });
}

module.exports = { 
  addSiteResolver, 
  sitesResolver, 
  runSiteResolver, 
  stopSiteResolver, 
  removeSiteResolver, 
  sitePointResolver, 
  simsResolver, 
  advanceResolver,
  writePointResolver,
  forecastsResolver
};


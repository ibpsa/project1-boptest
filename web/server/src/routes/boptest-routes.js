import express from 'express';
import got from 'got'
import {getResults} from '../controllers/result';
import {getKPIs} from '../controllers/kpi';
import {getInputs} from '../controllers/input';
import {getMeasurements} from '../controllers/measurement';
import {getStep, setStep} from '../controllers/step';
import {initialize} from '../controllers/test';
const boptestRoutes = express.Router();


// Post a query to the graphql api
const graphqlPost = async (querystring, baseurl) => {
  const {body} = await got.post( baseurl + '/graphql', {
    json: {
      query: querystring
    }
  });
  return body;
};

const graphqlPostAndRespond = (querystring, req, res, next) => {
  const baseurl = baseurlFromReq(req);
  graphqlPost(querystring, baseurl).then((body) => res.send(body)).catch((e) => next(e));
};

const promiseTaskLater = (task, time, ...args) => {
  return new Promise((resolve, reject) => {
    setTimeout(async () => {
      try {
        await task(...args);
        resolve();
      } catch (e) {
        reject(e);
      }
    }, time);
  });
};

const simStatus = async (id, baseurl) => {
  try {
    const querystring = `{ viewer{ sites(siteRef: "${id}") { simStatus } } }`;
    const body = await graphqlPost(querystring, baseurl);
    return JSON.parse(body)["data"]["viewer"]["sites"][0]["simStatus"];
  } catch (e) {
    console.log("Error retriving sim status");
    throw(e);
  }
};

const waitForSimStatus = async (id, baseurl, desiredStatus, count, maxCount) => {
  let i = 0;
  const currentStatus = await simStatus(id, baseurl);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count == maxCount) {
    throw(`Timeout waiting for sim: ${id} to reach status: ${desiredStatus}`);
  } else {
    await promiseTaskLater(waitForSimStatus, 2000, id, baseurl, desiredStatus, count, maxCount);
  }
};

//boptestRoutes.post('/advance/:id', async (req, res, next) => {
//  try {
//    const baseurl = baseurlFromReq(req);
//
//    // Set inputs
//    const inputdata = req.body;
//    const inputnames = Object.keys(inputdata).filter(key => (key.endsWith('_activate'))).map(key => key.replace(/_activate$/,""));
//    for (let inputname of inputnames) {
//      const inputvalue = inputdata['inputname' + '_u'];
//      const inputactivate = inputdata['inputname' + '_activate'];
//      let writestring = '';
//      if (inputvalue && inputactivate) {
//        writestring = `mutation { writePoint(siteRef: "${req.params.id}", pointName: "${inputname}", value: ${inputvalue}, level: 1 ) }`;
//      } else {
//        // Resets the input, ie. not activated
//        writestring = `mutation { writePoint(siteRef: "${req.params.id}", pointName: "${inputname}", level: 1 ) }`;
//      }
//      await graphqlPost(writestring, baseurl);
//    }
//
//    // Advance the sim
//    const advancestring = `mutation { advance(siteRefs: "${req.params.id}") }`;
//    await graphqlPost(advancestring, baseurl);
//
//    // Send back measurements
//    const {body} = await got.get(`${baseurl}/measurements/${req.params.id}`);
//    res.send(body);
//  } catch (e) {
//    next(e);
//  }
//  // TODO do the above in a single operation against Redis. This is very inefficient
//});

boptestRoutes.put('/initialize/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const sqs = req.app.get('sqs')
    const start_time = req.body['start_time']
    const warmup_period = req.body['warmup_period']
    const y = await initialize(req.params.id, start_time, warmup_period, redis, sqs)
    res.send(y)
  } catch (e) {
    next(e)
  }
});

boptestRoutes.put('/stop/:id', async (req, res, next) => {
  try {
    const querystring = `mutation{
      stopSite(
        siteRef: "${req.params.id}"
      )
    }`;

    const baseurl = baseurlFromReq(req);
    await graphqlPost(querystring, baseurl);
    await waitForSimStatus(req.params.id, baseurl, "Stopped", 0, 3);
    res.end();
  } catch (e) {
    next(e);
  }
});

boptestRoutes.get('/measurements/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db');
    const measurements = await getMeasurements(req.params.id, db)
    res.send(measurements)
  } catch (e) {
    next(e)
  }
});

boptestRoutes.get('/inputs/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db');
    const inputs = await getInputs(req.params.id, db)
    res.send(inputs)
  } catch (e) {
    next(e)
  }
})

boptestRoutes.get('/step/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    const step = await getStep(req.params.id, db, redis)
    res.send(step.toString())
  } catch (e) {
    next(e)
  }
})

boptestRoutes.put('/step/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    const step = req.body['step']
    await setStep(req.params.id, step, db, redis)
    res.sendStatus(200)
  } catch (e) {
    next(e)
  }
});

boptestRoutes.get('/kpi/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const id = req.params.id
    const kpis = await getKPIs(id, redis)
    res.send(kpis)
  } catch (e) {
    next(e);
  }
});

boptestRoutes.put('/results/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const id = req.params.id
    const point_name = req.body['point_name']
    const start_time = req.body['start_time']
    const final_time = req.body['final_time']
    const results = await getResults(id, point_name, start_time, final_time, redis)
    res.send(results)
  } catch (e) {
    next(e);
  }
});

boptestRoutes.get('/forecast_parameters/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    redis.hmget(req.params.id, 'forecast:horizon', 'forecast:interval', (err, redisres) => {
      if (err) {
        next(err);
      } else {
        res.send(redisres);
      }
    });
  } catch (e) {
    next(e);
  }
});

boptestRoutes.put('/forecast_parameters/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const horizon = req.body['horizon'];
    const interval = req.body['interval'];
    redis.hmset(req.params.id, 'forecast:horizon', horizon, 'forecast:interval', interval, (err) => {
      if (err) {
        next(err);
      } else {
        res.end();
      }
    });
  } catch (e) {
    next(e);
  }
});

boptestRoutes.get('/forecast/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    redis.hget(req.params.id, 'forecast', (err, redisres) => {
      if (err) {
        next(err);
      } else {
        res.send(redisres);
      }
    });
  } catch (e) {
    next(e);
  }
});

export default boptestRoutes;

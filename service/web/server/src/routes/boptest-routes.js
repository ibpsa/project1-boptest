import express from 'express';
import got from 'got'
const boptestRoutes = express.Router();


//let response = {};
//for (let point of points) {
//  const tags = point["tags"];
//  // This is a string. Should it be returned as a number?
//  const curVal = strip(tags.find(tag => tag["key"] == "curVal") ["value"]);
//  const dis = strip(point["dis"]);
//  response[dis] = curVal;
//}
//res.send(response);

// Given an array of points with tags, return an object,
// "dis" values are the keys, and "curVal" are the values
const pointsToCurVals = (points) => {
  let response = {};
  for (let point of points) {
    const tags = point["tags"];
    // This is a string. Should it be returned as a number?
    const curValTag = tags.find(tag => tag["key"] == "curVal");
    // What do return if there is no curVal?
    let curVal = null;
    if (curValTag) {
      curVal = Number.parseFloat(strip(curValTag["value"]));
    }
    const dis = strip(point["dis"]);
    response[dis] = curVal;
  }
  return response;
};

const baseurlFromReq = (req) => {
  return req.protocol + '://' + req.get('host');
};

// Remove any preceeding haystack style type specifier. 
// ie given "n:1.0" will return "1.0"
const strip = (text) => {
  return text.replace(/^\w:/,"");
}

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

boptestRoutes.post('/advance/:id', async (req, res, next) => {
  try {
    const baseurl = baseurlFromReq(req);

    // Set inputs
    const inputdata = req.body;
    const inputnames = Object.keys(inputdata).filter(key => (key.endsWith('_activate'))).map(key => key.replace(/_activate$/,""));
    for (let inputname of inputnames) {
      const inputvalue = inputdata['inputname' + '_u'];
      const inputactivate = inputdata['inputname' + '_activate'];
      let writestring = '';
      if (inputvalue && inputactivate) {
        writestring = `mutation { writePoint(siteRef: "${req.params.id}", pointName: "${inputname}", value: ${inputvalue}, level: 1 ) }`;
      } else {
        // Resets the input, ie. not activated
        writestring = `mutation { writePoint(siteRef: "${req.params.id}", pointName: "${inputname}", level: 1 ) }`;
      }
      await graphqlPost(writestring, baseurl); 
    }
    
    // Advance the sim
    const advancestring = `mutation { advance(siteRefs: "${req.params.id}") }`;
    await graphqlPost(advancestring, baseurl);

    // Send back measurements
    const {body} = await got.get(`${baseurl}/measurements/${req.params.id}`);
    res.send(body);
  } catch (e) {
    next(e);
  }
  // TODO do the above in a single operation against Redis. This is very inefficient
});

boptestRoutes.put('/initialize/:id', async (req, res, next) => {
  try {
    const querystring = `mutation{
      runSite(
        siteRef: "${req.params.id}",
        startDatetime: "0",
        endDatetime: "86400",
        externalClock: true,
      	timescale: 1.0
      )
    }`;
    
    const baseurl = baseurlFromReq(req);
    await graphqlPost(querystring, baseurl); 
    await waitForSimStatus(req.params.id, baseurl, "Running", 0, 3);
    res.end();
  } catch (e) {
    next(e);
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
    const baseurl = baseurlFromReq(req);
    const querystring = `query { viewer { sites(siteRef: "${req.params.id}") { datetime, points(cur: true) { dis tags { key value } } } } }`;
    const jsondata = JSON.parse(await graphqlPost(querystring, baseurl));
    const points = jsondata["data"]["viewer"]["sites"][0]["points"];
    const response = pointsToCurVals(points);

    // BOPTEST includes 'time' key in the measurements
    response['time'] = jsondata["data"]["viewer"]["sites"][0]["datetime"];

    res.send(response);
  } catch (e) {
    next(e);
  }
});

boptestRoutes.get('/inputs/:id', async (req, res, next) => {
  try {
    const baseurl = baseurlFromReq(req);
    const querystring = `query { viewer { sites(siteRef: "${req.params.id}") { points(writable: true) { dis tags { key value } } } } }`;
    const points = JSON.parse(await graphqlPost(querystring, baseurl))["data"]["viewer"]["sites"][0]["points"];
    const response = pointsToCurVals(points);
    res.send(response);
  } catch (e) {
    next(e);
  }
});

boptestRoutes.get('/step/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    redis.hget(req.params.id, 'stepsize', (err, redisres) => {
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

boptestRoutes.put('/step/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const stepsize = req.body['step'];
    redis.hset(req.params.id, 'stepsize', stepsize, (err) => {
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

boptestRoutes.get('/kpi/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    redis.hget(req.params.id, 'kpis', (err, redisres) => {
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

boptestRoutes.get('/results/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    redis.hget(req.params.id, 'results', (err, redisres) => {
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

// results are valid before simulation is complete. just return from start to current time (not counting warmup)
// kpis are the same as results ie valid until current time
// some controllers *might* use results in realtime
// need to add forecast_parameters get / set

export default boptestRoutes;




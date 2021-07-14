import express from 'express';
import {body} from 'express-validator';
import got from 'got'
import {getVersion} from '../controllers/utility';
import {
  getTestcases,
  select
} from '../controllers/testcase';
import {
  getName,
  initialize,
  advance,
  stop,
  getMeasurements,
  getInputs,
  getForecastParameters,
  setForecastParameters,
  getForecast,
  setScenario,
  getScenario,
  setStep,
  getStep,
  getKPIs,
  getResults,
  getStatus,
  getTestcaseID
} from '../controllers/test';

const boptestRouter = express.Router();

boptestRouter.get('/version', async (req, res, next) => {
  try {
    const v = await getVersion()
    res.send(v)
  } catch (e) {
    next(e)
  }
})

boptestRouter.post('/testcases/:testcaseid/select', async (req, res, next) => {
  try {
    const testcaseid = req.params.testcaseid
    const db = req.app.get('db')
    const redis = req.app.get('redis')
    const sqs = req.app.get('sqs')
    const response = await select(testcaseid, db, redis, sqs)
    return res.send(response)
  } catch (e) {
    next(e)
  }
});

boptestRouter.put('/stop/:testid', async (req, res, next) => {
  try {
    const pub = req.app.get('pub')
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    await stop(req.params.testid, db, redis, pub)
    res.sendStatus(200)
  } catch (e) {
    next(e)
  }
});

boptestRouter.get('/status/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const redis = req.app.get('redis')
    const s = await getStatus(req.params.id, db, redis)
    res.send(s)
  } catch (e) {
    next(e)
  }
})

boptestRouter.get('/name/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const name = await getName(req.params.id, redis)
    res.send(name)
  } catch (e) {
    next(e)
  }
})

// Validate body, such that it contains only valid control input names.
const validateControlInputs = async (body, {req}) => {
  // This is a custom validator because the valid input names are
  // a dynamic value based on the test case name
  // Also, the entire body content is validated at once, rather than
  // field by field validators so that getInputs is only called once, per request
  const db = req.app.get('db')
  const redis = req.app.get('redis')
  const testid = req.params.id
  const testcaseid = getTestcaseID(testid, redis)
  const input_names = Object.keys(await getInputs(testcaseid, db))
  const invalid_names = []

  for (const key in body) {
    if (! input_names.includes(key) ) {
      invalid_names.push(key)
    }
  }

  if (invalid_names.length > 0) {
    throw new Error('Invalid control input: ', invalid_names.toString())
  }

  return true
}

boptestRouter.post('/advance/:testid', body().custom(validateControlInputs), async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const u = req.body
    const y = await advance(req.params.testid, redis, u)
    res.send(y)
  } catch (e) {
    next(e)
  }
});

boptestRouter.put('/initialize/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    const sqs = req.app.get('sqs')
    const params = req.body
    const response = await initialize(req.params.testid, params, db, redis, sqs)
    res.send(response)
  } catch (e) {
    next(e)
  }
});

boptestRouter.put('/scenario/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const redis = req.app.get('redis')
    const sqs = req.app.get('sqs')
    const pub = req.app.get('pub')
    const electricity_price = req.body['electricity_price'] || null
    const time_period = req.body['time_period'] || null
    const scenario = { electricity_price, time_period }
    const scenario_set = await setScenario(req.params.id, scenario, db, redis, sqs, pub)
    res.send(scenario_set)
  } catch (e) {
    next(e)
  }
});

boptestRouter.get('/scenario/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const redis = req.app.get('redis')
    const scenario = await getScenario(req.params.id, db, redis)
    res.send(scenario)
  } catch (e) {
    next(e)
  }
});

boptestRouter.get('/measurements/:testid', async (req, res, next) => {
  try {
    const db = req.app.get('db');
    const redis = req.app.get('redis')
    const measurements = await getMeasurements(req.params.testid, db, redis)
    res.send(measurements)
  } catch (e) {
    next(e)
  }
});

boptestRouter.get('/inputs/:testid', async (req, res, next) => {
  try {
    const db = req.app.get('db');
    const redis = req.app.get('redis')
    const inputs = await getInputs(req.params.testid, db, redis)
    res.send(inputs)
  } catch (e) {
    next(e)
  }
})

boptestRouter.get('/step/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    const step = await getStep(req.params.testid, db, redis)
    res.send(step)
  } catch (e) {
    next(e)
  }
})

boptestRouter.put('/step/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    const step = req.body['step']
    await setStep(req.params.testid, step, db, redis)
    res.sendStatus(200)
  } catch (e) {
    next(e)
  }
});

boptestRouter.get('/kpi/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const kpis = await getKPIs(req.params.testid, redis)
    res.send(kpis)
  } catch (e) {
    next(e);
  }
});

boptestRouter.put('/results/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const testid = req.params.testid
    const point_name = req.body['point_name']
    const start_time = req.body['start_time']
    const final_time = req.body['final_time']
    const results = await getResults(testid, point_name, start_time, final_time, redis)
    res.send(results)
  } catch (e) {
    next(e);
  }
});

boptestRouter.get('/forecast_parameters/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const testid = req.params.testid
    const forecast_parameters = await getForecastParameters(testid, redis)
    res.send(forecast_parameters)
  } catch (e) {
    next(e);
  }
});

boptestRouter.put('/forecast_parameters/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const testid = req.params.testid
    const horizon = req.body['horizon']
    const interval = req.body['interval']
    const forecast_parameters = await setForecastParameters(testid, horizon, interval, redis)
    res.send(forecast_parameters)
  } catch (e) {
    next(e);
  }
});

boptestRouter.get('/forecast/:testid', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const testid = req.params.testid
    const forecast = await getForecast(testid, redis)
    res.send(forecast)
  } catch (e) {
    next(e);
  }
});

boptestRouter.get('/testcases', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const testcaseids = await getTestcases(db)
    res.send(testcaseids)
  } catch (e) {
    next(e);
  }
})

export default boptestRouter;

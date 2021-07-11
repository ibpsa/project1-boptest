import express from 'express';
import {body} from 'express-validator';
import got from 'got'
import {getVersion} from '../controllers/utility';
import {
  createOrUpdateTestcase,
  getMeasurements,
  getInputs,
  getName
} from '../controllers/testcase';
import {
  initialize,
  advance,
  stop,
  getForecastParameters,
  setForecastParameters,
  getForecast,
  setScenario,
  getScenario,
  setStep,
  getStep,
  getKPIs,
  getResults,
  getStatus
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
    const db = req.app.get('db')
    const name = await getName(req.params.id, db)
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
  const id = req.params.id
  const input_names = Object.keys(await getInputs(id, db))
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

boptestRouter.post('/advance/:id', body().custom(validateControlInputs), async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const advancer = req.app.get('advancer')
    const u = req.body
    const y = await advance(req.params.id, redis, advancer, u)
    res.send(y)
  } catch (e) {
    next(e)
  }
});

boptestRouter.put('/initialize/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    const sqs = req.app.get('sqs')
    const start_time = req.body['start_time']
    const warmup_period = req.body['warmup_period']
    const y = await initialize(req.params.id, start_time, warmup_period, db, redis, sqs)
    res.send(y)
  } catch (e) {
    next(e)
  }
});

boptestRouter.put('/stop/:id', async (req, res, next) => {
  try {
    const pub = req.app.get('pub')
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    await stop(req.params.id, db, redis, pub)
    res.sendStatus(200)
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

boptestRouter.get('/measurements/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db');
    const measurements = await getMeasurements(req.params.id, db)
    res.send(measurements)
  } catch (e) {
    next(e)
  }
});

boptestRouter.get('/inputs/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db');
    const inputs = await getInputs(req.params.id, db)
    res.send(inputs)
  } catch (e) {
    next(e)
  }
})

boptestRouter.get('/step/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis')
    const db = req.app.get('db')
    const step = await getStep(req.params.id, db, redis)
    res.send(step.toString())
  } catch (e) {
    next(e)
  }
})

boptestRouter.put('/step/:id', async (req, res, next) => {
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

boptestRouter.get('/kpi/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const id = req.params.id
    const kpis = await getKPIs(id, redis)
    res.send(kpis)
  } catch (e) {
    next(e);
  }
});

boptestRouter.put('/results/:id', async (req, res, next) => {
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

boptestRouter.get('/forecast_parameters/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const id = req.params.id
    const forecast_parameters = await getForecastParameters(id, redis)
    res.send(forecast_parameters)
  } catch (e) {
    next(e);
  }
});

boptestRouter.put('/forecast_parameters/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const id = req.params.id
    const horizon = req.body['horizon']
    const interval = req.body['interval']
    const forecast_parameters = await setForecastParameters(id, horizon, interval, redis)
    res.send(forecast_parameters)
  } catch (e) {
    next(e);
  }
});

boptestRouter.get('/forecast/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const id = req.params.id
    const forecast = await getForecast(id, redis)
    res.send(forecast)
  } catch (e) {
    next(e);
  }
});

export default boptestRouter;

import express from 'express';
import got from 'got'
import {getResults} from '../controllers/result';
import {getKPIs} from '../controllers/kpi';
import {getInputs} from '../controllers/input';
import {getMeasurements} from '../controllers/measurement';
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
  getStep
} from '../controllers/test';

const boptestRoutes = express.Router();

boptestRoutes.post('/advance/:id', async (req, res, next) => {
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
    const pub = req.app.get('pub')
    const redis = req.app.get('redis')
    await stop(req.params.id, redis, pub)
    res.sendStatus(200)
  } catch (e) {
    next(e)
  }
});

boptestRoutes.put('/scenario/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const redis = req.app.get('redis')
    const sqs = req.app.get('sqs')
    const electricity_price = req.body['electricity_price']
    const scenario = {electricity_price}
    const scenario_set = await setScenario(req.params.id, scenario, db, redis, sqs)
    res.send(scenario_set)
  } catch (e) {
    next(e)
  }
});

boptestRoutes.get('/scenario/:id', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const redis = req.app.get('redis')
    const scenario = await getScenario(req.params.id, db, redis)
    res.send(scenario)
  } catch (e) {
    next(e)
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
    const id = req.params.id
    const forecast_parameters = await getForecastParameters(id, redis)
    res.send(forecast_parameters)
  } catch (e) {
    next(e);
  }
});

boptestRoutes.put('/forecast_parameters/:id', async (req, res, next) => {
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

boptestRoutes.get('/forecast/:id', async (req, res, next) => {
  try {
    const redis = req.app.get('redis');
    const id = req.params.id
    const forecast = await getForecast(id, redis)
    res.send(forecast)
  } catch (e) {
    next(e);
  }
});

export default boptestRoutes;

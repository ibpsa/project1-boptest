import express from 'express'
import {body, param, validationResult} from 'express-validator'
import got from 'got'
import {getVersion} from '../controllers/utility'
import {
  isTestcase,
  getTestcases,
  select
} from '../controllers/testcase'
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
} from '../controllers/test'
import {
  validateTestid,
  validateControlInputs
} from './validators'


const boptestRouter = express.Router()


boptestRouter.get('/version', async (req, res, next) => {
  try {
    const v = await getVersion()
    res.send(v)
  } catch (e) {
    next(e)
  }
})

boptestRouter.post('/testcases/:testcaseid/select', 
  body(['api_key']).optional(),
  async (req, res, next) => {
  try {
    const testcaseid = req.params.testcaseid
    const api_key = req.body['api_key'] || null
    const sqs = req.app.get('sqs')
    const response = await select(testcaseid, sqs, api_key)
    return res.send(response)
  } catch (e) {
    next(e)
  }
});

boptestRouter.put('/stop/:testid', 
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      await stop(req.params.testid)
      res.sendStatus(200)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.get('/status/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const s = await getStatus(req.params.testid)
      res.send(s)
    } catch (e) {
      next(e)
    }
  }
)

boptestRouter.get('/name/:testid', 
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const name = await getName(req.params.testid)
      res.send(name)
    } catch (e) {
      next(e)
    }
  }
)

boptestRouter.post('/advance/:testid',
  param('testid').custom(validateTestid),
  body().custom(validateControlInputs),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const u = req.body
      const y = await advance(req.params.testid, u)
      res.send(y)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.put('/initialize/:testid',
  param('testid').custom(validateTestid),
  body(['start_time', 'warmup_period']).isNumeric(),
  body('end_time').optional().isNumeric(),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const params = req.body
      const response = await initialize(req.params.testid, params)
      res.send(response)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.put('/scenario/:testid',
  param('testid').custom(validateTestid),
  body(['electricity_price', 'time_period']).optional(),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const electricity_price = req.body['electricity_price'] || null
      const time_period = req.body['time_period'] || null
      const scenario = { electricity_price, time_period }
      const scenario_set = await setScenario(req.params.testid, scenario)
      res.send(scenario_set)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.get('/scenario/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const scenario = await getScenario(req.params.testid)
      res.send(scenario)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.get('/measurements/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const db = req.app.get('db');
      const measurements = await getMeasurements(req.params.testid, db)
      res.send(measurements)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.get('/inputs/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const db = req.app.get('db');
      const inputs = await getInputs(req.params.testid, db)
      res.send(inputs)
    } catch (e) {
      next(e)
    }
  }
)

boptestRouter.get('/step/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const step = await getStep(req.params.testid)
      res.send(step)
    } catch (e) {
      next(e)
    }
  }
)

boptestRouter.put('/step/:testid',
  param('testid').custom(validateTestid),
  body('step').isNumeric(),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const step = req.body['step']
      await setStep(req.params.testid, step)
      res.sendStatus(200)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.get('/kpi/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const kpis = await getKPIs(req.params.testid)
      res.send(kpis)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.put('/results/:testid',
  param('testid').custom(validateTestid),
  body(['point_name', 'start_time', 'final_time']).exists(),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const point_name = req.body['point_name']
      const start_time = req.body['start_time']
      const final_time = req.body['final_time']
      const results = await getResults(testid, point_name, start_time, final_time)
      res.send(results)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.get('/forecast_parameters/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const forecast_parameters = await getForecastParameters(testid)
      res.send(forecast_parameters)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.put('/forecast_parameters/:testid',
  param('testid').custom(validateTestid),
  body(['horizon', 'interval']).isNumeric(),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const horizon = req.body['horizon']
      const interval = req.body['interval']
      const forecast_parameters = await setForecastParameters(testid, horizon, interval)
      res.send(forecast_parameters)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.get('/forecast/:testid', 
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const forecast = await getForecast(testid)
      res.send(forecast)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.get('/testcases', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const testcaseids = await getTestcases(db)
    res.send(testcaseids)
  } catch (e) {
    next(e);
  }
})

boptestRouter.get('/testcases/:testcaseid', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const testcaseid = req.params.testcaseid
    if (await isTestcase(testcaseid, db)) {
      res.sendStatus(200)
    } else {
      res.sendStatus(404)
    }
  } catch (e) {
    next(e);
  }
})

export default boptestRouter;

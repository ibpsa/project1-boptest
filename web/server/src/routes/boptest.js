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
  getTestcaseID,
  submit
} from '../controllers/test'
import {
  validateTestid,
  validateControlInputs
} from './validators'


const boptestRouter = express.Router()

boptestRouter.get('/version', async (req, res, next) => {
  try {
    const payload = await getVersion()
    res.status(payload.status).json(payload)
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
    return res.json(response)
  } catch (e) {
    next(e)
  }
});

boptestRouter.post('/submit/:testid', 
  async (req, res, next) => {
  try {
    const body = req.body;
    const api_key = body.api_key
    let unit_test = false
    let tags = []
    for (const key in body) {
      if (key.startsWith('tag') && body[key]) {
        tags.push(body[key])
      }
      if ((key == 'unit_test') && body[key]) {
        unit_test = true
      }
    }
    const payload = await submit(req.params.testid, api_key, tags, unit_test)
    console.log('message: ', payload.message)
    console.log('payload: ', payload)
    res.status(payload.status).json(payload)
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
      const payload = await getStatus(req.params.testid)
      res.json(payload)
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
      const payload = await getName(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

boptestRouter.post('/advance/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const args = req.body
      const payload = await advance(req.params.testid, args)
      res.status(payload.status).send(payload)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.put('/initialize/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const args = req.body
      const payload = await initialize(req.params.testid, args)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

boptestRouter.put('/scenario/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const electricity_price = req.body['electricity_price'] || null
      const time_period = req.body['time_period'] || null
      const scenario = { electricity_price, time_period }
      const payload = await setScenario(req.params.testid, scenario)
      res.status(payload.status).json(payload)
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
      const payload = await getScenario(req.params.testid)
      res.status(payload.status).json(payload)
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
      const payload = await getMeasurements(req.params.testid, db)
      res.status(payload.status).json(payload)
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
      const payload = await getInputs(req.params.testid, db)
      res.status(payload.status).json(payload)
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
      const payload = await getStep(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

boptestRouter.put('/step/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const step = req.body['step']
      const payload = await setStep(req.params.testid, step)
      res.status(payload.status).json(payload)
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
      const payload = await getKPIs(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.put('/results/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const point_name = req.body['point_name']
      const start_time = req.body['start_time']
      const final_time = req.body['final_time']
      const payload = await getResults(testid, point_name, start_time, final_time)
      res.status(payload.status).json(payload)
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
      const payload = await getForecastParameters(testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.put('/forecast_parameters/:testid',
  param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const horizon = req.body['horizon']
      const interval = req.body['interval']
      const payload = await setForecastParameters(testid, horizon, interval)
      res.status(payload.status).json(payload)
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
      const payload = await getForecast(testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

boptestRouter.get('/testcases', async (req, res, next) => {
  try {
    const db = req.app.get('db')
    const payload = await getTestcases(db)
    res.json(payload)
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

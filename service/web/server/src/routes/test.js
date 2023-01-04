import express from 'express'
import got from 'got'
import {body, param, validationResult} from 'express-validator'
import * as controller from '../controllers/test'
import * as middleware from './middleware'
import {validateTestid} from './validators'

const testRoutes = express.Router()

testRoutes.get('/version', async (req, res, next) => {
  try {
    const payload = await getVersion()
    res.status(payload.status).json(payload)
  } catch (e) {
    next(e)
  }
})

testRoutes.post('/submit/:testid', 
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
    const payload = await controller.submit(req.params.testid, api_key, tags, unit_test)
    res.status(payload.status).json(payload)
  } catch (e) {
    next(e)
  }
});

testRoutes.put('/stop/:testid', 
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      await controller.stop(req.params.testid)
      res.sendStatus(200)
    } catch (e) {
      next(e)
    }
  }
);

testRoutes.get('/status/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const payload = await controller.getStatus(req.params.testid)
      res.json(payload)
    } catch (e) {
      next(e)
    }
  }
)

testRoutes.get('/name/:testid', 
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const payload = await controller.getName(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

testRoutes.post('/advance/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const args = req.body
      const payload = await controller.advance(req.params.testid, args)
      res.status(payload.status).send(payload)
    } catch (e) {
      next(e)
    }
  }
);

testRoutes.put('/initialize/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const args = req.body
      const payload = await controller.initialize(req.params.testid, args)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

testRoutes.put('/scenario/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const electricity_price = req.body['electricity_price'] || null
      const time_period = req.body['time_period'] || null
      const scenario = { electricity_price, time_period }
      const payload = await controller.setScenario(req.params.testid, scenario)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

testRoutes.get('/scenario/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const payload = await controller.getScenario(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

testRoutes.get('/measurements/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const db = req.app.get('db');
      const payload = await controller.getMeasurements(req.params.testid, db)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

testRoutes.get('/inputs/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const db = req.app.get('db');
      const payload = await controller.getInputs(req.params.testid, db)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

testRoutes.get('/step/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const payload = await controller.getStep(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

testRoutes.put('/step/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const step = req.body['step']
      const payload = await controller.setStep(req.params.testid, step)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

testRoutes.get('/kpi/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const payload = await controller.getKPIs(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

testRoutes.put('/results/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const point_name = req.body['point_name']
      const start_time = req.body['start_time']
      const final_time = req.body['final_time']
      const payload = await controller.getResults(testid, point_name, start_time, final_time)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

testRoutes.get('/forecast_parameters/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const payload = await controller.getForecastParameters(testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

testRoutes.put('/forecast_parameters/:testid',
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const horizon = req.body['horizon']
      const interval = req.body['interval']
      const payload = await controller.setForecastParameters(testid, horizon, interval)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

testRoutes.get('/forecast/:testid', 
  //param('testid').custom(validateTestid),
  async (req, res, next) => {
    try {
      validationResult(req).throw()
      const testid = req.params.testid
      const payload = await controller.getForecast(testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

//const getTests = async (req, res, next) => {
//  try {
//    const payload = await controller.getTests(req.userID);
//    res.json(payload)
//  } catch (e) {
//    next(e)
//  }
//}

//testRoutes.get('/tests', async (req, res, next) => {
//  //getTests(req, res, next);
//})

export default testRoutes;

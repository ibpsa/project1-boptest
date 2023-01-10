import express from 'express'
import got from 'got'
import { param } from 'express-validator'
import { validateTestid } from './validators'
import * as boptestLib from '../lib/boptestLib'
import * as middleware from './middleware'

const boptestRoutes = express.Router()
const ibpsaNamespace = 'ibpsa'
const bucket = process.env.BOPTEST_S3_BUCKET
const s3PublicURL = process.env.BOPTEST_PUBLIC_S3_URL + '/' + bucket

// GET Version //

boptestRoutes.get('/version', async (req, res, next) => {
  try {
    const payload = await boptestLib.getVersion()
    res.status(payload.status).json(payload)
  } catch (e) {
    next(e)
  }
})

// GET test case post-form //

const getTestcasePostForm = async (req, res, next) => {
  res.json(await boptestLib.getTestcasePostForm(req.testcaseKey, s3PublicURL))
}

boptestRoutes.get('/testcases/:testcaseID/post-form',
  middleware.identify,
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

boptestRoutes.get('/testcases/:testcaseNamespace/:testcaseID/post-form',
  middleware.identify,
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

boptestRoutes.get('/users/:userName/testcases/:testcaseID/post-form',
  middleware.identify,
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForUserTestcase(req.account.dis, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

// Delete test case //

const deleteTestcase = async (req, res, next) => {
  if (await boptestLib.isTestcase(req.testcaseKeyPrefix, req.testcaseID)) {
    await boptestLib.deleteTestcase(req.testcaseKey)
    res.sendStatus(200)
  } else {
    res.sendStatus(404)
  }
}

boptestRoutes.delete('/testcases/:testcaseID',
  middleware.identify,
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = boptestLib.getPrefixForTestcase(ibpsaNamespace)
    req.testcaseKey = boptestLib.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

boptestRoutes.delete('/testcases/:testcaseNamespace/:testcaseID',
  middleware.identify,
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = boptestLib.getPrefixForTestcase(req.params.testcaseNamespace)
    req.testcaseKey = boptestLib.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

boptestRoutes.delete('/users/:userName/testcases/:testcaseID',
  middleware.identify,
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = boptestLib.getPrefixForUserTestcase(req.account.dis)
    req.testcaseKey = boptestLib.getKeyForUserTestcase(req.account.dis, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

// POST test case select //

const select = async (req, res, next) => {
  let userSub = undefined
  if (req.account) {
    userSub = req.account.sub
  }
  res.json(await boptestLib.select(req.testcaseKey, userSub, req.params.async))
}

boptestRoutes.post('/testcases/:testcaseID/select-?:async?',
  middleware.identify,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  select
)

boptestRoutes.post('/testcases/:testcaseNamespace/:testcaseID/select-?:async?',
  middleware.identify,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  select
);

boptestRoutes.post('/users/:userName/testcases/:testcaseID/select-?:async?',
  middleware.identify,
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForUserTestcase(req.account.dis, req.params.testcaseID)
    next()
  },
  select
);

// Get testcases //

const getTestcases = async (req, res, next) => {
  res.json(await boptestLib.getTestcases(req.testcaseKeyPrefix))
}

boptestRoutes.get('/testcases', 
  middleware.identify,
  (req, res, next) => {
    req.testcaseKeyPrefix = boptestLib.getPrefixForTestcase(ibpsaNamespace)
    next()
  },
  getTestcases
)

boptestRoutes.get('/testcases/:testcaseNamespace',
  middleware.identify,
  (req, res, next) => {
    req.testcaseKeyPrefix = boptestLib.getPrefixForTestcase(req.params.testcaseNamespace)
    next()
  },
  getTestcases
)

boptestRoutes.get('/users/:userName/testcases',
  middleware.identify,
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseKeyPrefix = boptestLib.getPrefixForUserTestcase(req.account.dis)
    next()
  },
  getTestcases
)

// Get queued and running tests //

boptestRoutes.get('/users/:userName/tests', 
  middleware.identify,
  middleware.requireUser,
  async (req, res, next) => {
    const payload = await boptestLib.getTests(req.account.sub);
    res.json(payload)
  }
)

// PUT stop //

boptestRoutes.put('/stop/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      await boptestLib.stop(req.params.testid)
      res.sendStatus(200)
    } catch (e) {
      next(e)
    }
  }
);

// POST results //

boptestRoutes.post('/submit/:testid', 
  param('testid').custom(validateTestid),
  middleware.validationResponse,
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
    const payload = await boptestLib.submit(req.params.testid, api_key, tags, unit_test)
    res.status(payload.status).json(payload)
  } catch (e) {
    next(e)
  }
});

// GET status //

boptestRoutes.get('/status/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const payload = await boptestLib.getStatus(req.params.testid)
      res.json(payload.toString())
    } catch (e) {
      next(e)
    }
  }
)

// GET test name //

boptestRoutes.get('/name/:testid', 
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const payload = await boptestLib.getName(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

// POST advance //

boptestRoutes.post('/advance/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const args = req.body
      const payload = await boptestLib.advance(req.params.testid, args)
      res.status(payload.status).send(payload)
    } catch (e) {
      next(e)
    }
  }
);

// PUT initialize //

boptestRoutes.put('/initialize/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const args = req.body
      const payload = await boptestLib.initialize(req.params.testid, args)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

// PUT scenario //

boptestRoutes.put('/scenario/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const electricity_price = req.body['electricity_price'] || null
      const time_period = req.body['time_period'] || null
      const scenario = { electricity_price, time_period }
      const payload = await boptestLib.setScenario(req.params.testid, scenario)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

// GET scenario //

boptestRoutes.get('/scenario/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const payload = await boptestLib.getScenario(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

// GET measurements //

boptestRoutes.get('/measurements/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const db = req.app.get('db');
      const payload = await boptestLib.getMeasurements(req.params.testid, db)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

// GET inputs //

boptestRoutes.get('/inputs/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const db = req.app.get('db');
      const payload = await boptestLib.getInputs(req.params.testid, db)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

// GET step //

boptestRoutes.get('/step/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const payload = await boptestLib.getStep(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
)

// PUT step //

boptestRoutes.put('/step/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const step = req.body['step']
      const payload = await boptestLib.setStep(req.params.testid, step)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e)
    }
  }
);

// GET kpi //

boptestRoutes.get('/kpi/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const payload = await boptestLib.getKPIs(req.params.testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

// PUT results //

boptestRoutes.put('/results/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const testid = req.params.testid
      const point_name = req.body['point_name']
      const start_time = req.body['start_time']
      const final_time = req.body['final_time']
      const payload = await boptestLib.getResults(testid, point_name, start_time, final_time)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

// GET forecast_parameters //

boptestRoutes.get('/forecast_parameters/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const testid = req.params.testid
      const payload = await boptestLib.getForecastParameters(testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

// PUT forecast_parameters //

boptestRoutes.put('/forecast_parameters/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const testid = req.params.testid
      const horizon = req.body['horizon']
      const interval = req.body['interval']
      const payload = await boptestLib.setForecastParameters(testid, horizon, interval)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

// GET forecast //

boptestRoutes.get('/forecast/:testid', 
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const testid = req.params.testid
      const payload = await boptestLib.getForecast(testid)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

export default boptestRoutes;

import express from 'express'
import { param } from 'express-validator'
import { validateTestid } from './validators'
import * as boptestLib from '../lib/boptestLib'
import messaging from '../lib/messaging'
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
  res.json(await boptestLib.getTestcasePostForm(req.testcaseKey, s3PublicURL, req.share))
}

boptestRoutes.get('/testcases/:testcaseID/post-form',
  middleware.identify,
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    req.share = true
    next()
  },
  getTestcasePostForm
)

boptestRoutes.get('/testcases/:testcaseNamespace/:testcaseID/post-form',
  middleware.identify,
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    req.share = true
    next()
  },
  getTestcasePostForm
)

boptestRoutes.get('/users/:userName/testcases/:testcaseID/post-form',
  middleware.identify,
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseKey = boptestLib.getKeyForUserTestcase(req.account.sub, req.params.testcaseID)
    req.share = false
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
    req.testcaseKeyPrefix = boptestLib.getPrefixForUserTestcase(req.account.sub)
    req.testcaseKey = boptestLib.getKeyForUserTestcase(req.account.sub, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

// POST test case select //

const select = async (req, res, next) => {
  if (await boptestLib.isTestcase(req.testcaseKeyPrefix, req.testcaseID)) {
    let userSub = undefined
    if (req.account) {
      userSub = req.account.sub
    }
    res.json(await boptestLib.select(req.testcaseKey, userSub, req.params.async))
  } else {
    res.sendStatus(404)
  }
}

boptestRoutes.post('/testcases/:testcaseID/select-?:async?',
  middleware.identify,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = boptestLib.getPrefixForTestcase(ibpsaNamespace)
    req.testcaseKey = boptestLib.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  select
)

boptestRoutes.post('/testcases/:testcaseNamespace/:testcaseID/select-?:async?',
  middleware.identify,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = boptestLib.getPrefixForTestcase(req.params.testcaseNamespace)
    req.testcaseKey = boptestLib.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  select
);

boptestRoutes.post('/users/:userName/testcases/:testcaseID/select-?:async?',
  middleware.identify,
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = boptestLib.getPrefixForUserTestcase(req.account.sub)
    req.testcaseKey = boptestLib.getKeyForUserTestcase(req.account.sub, req.params.testcaseID)
    next()
  },
  select
);

// Get testcases //

const getTestcases = async (req, res, next) => {
  const testcases = await boptestLib.getTestcases(req.testcaseKeyPrefix)

  if (testcases.length == 0) {
    res.sendStatus(404)
  } else {
    res.json(testcases)
  }
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
    req.testcaseKeyPrefix = boptestLib.getPrefixForUserTestcase(req.account.sub)
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'post_results_to_dashboard', req.body)
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_name', {})
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'advance', req.body)
      res.status(payload.status).json(payload)
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'initialize', req.body)
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'set_scenario', req.body)
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_scenario', {})
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_measurements', {})
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_inputs', {})
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_step', {})
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'set_step', req.body)
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
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_kpis', {})
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
      // requests sent as form data may need to coherce the point_names into an Array
      // This is workaround, sending json does not require this
      if (typeof req.body.point_names == 'string') {
        req.body['point_names'] = [req.body.point_names]
      }
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_results', req.body)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

// PUT forecast //

boptestRoutes.put('/forecast/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      // requests sent as form data may need to coherce the point_names into an Array
      // This is workaround, sending json does not require this
      if (typeof req.body.point_names == 'string') {
        req.body['point_names'] = [req.body.point_names]
      }
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_forecast', req.body)
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

// GET forecast_points //

boptestRoutes.get('/forecast_points/:testid',
  param('testid').custom(validateTestid),
  middleware.validationResponse,
  async (req, res, next) => {
    try {
      const payload = await messaging.callWorkerMethod(req.params.testid, 'get_forecast_points', {})
      res.status(payload.status).json(payload)
    } catch (e) {
      next(e);
    }
  }
);

// Check identity for all generic endpoints under /users and /testcases
// Specific endpoints will have already been handled from the preceeding routes
// If the Authorization header is invalid then the middleware will send 401
boptestRoutes.all('/testcases/*', middleware.identify)
boptestRoutes.all('/users', middleware.identify)
boptestRoutes.all('/users/*', middleware.identify)
boptestRoutes.all('/users/:userName', middleware.requireUser)
boptestRoutes.all('/users/:userName/*', middleware.requireUser)

export default boptestRoutes;

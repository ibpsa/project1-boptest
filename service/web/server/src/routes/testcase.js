import express from 'express';
import got from 'got';
import * as controller from '../controllers/testcase'
import * as middleware from './middleware'

const testcaseRoutes = express.Router()
const ibpsaNamespace = 'ibpsa'
const bucket = process.env.BOPTEST_S3_BUCKET
const s3PublicURL = process.env.BOPTEST_PUBLIC_S3_URL + '/' + bucket

testcaseRoutes.use(middleware.identify)

// GET test case post-form //

const getTestcasePostForm = async (req, res, next) => {
  res.json(await controller.getTestcasePostForm(req.testcaseKey, s3PublicURL))
}

testcaseRoutes.get('/testcases/:testcaseID/post-form',
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

testcaseRoutes.get('/testcases/:testcaseNamespace/:testcaseID/post-form',
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

testcaseRoutes.get('/users/:userName/testcases/:testcaseID/post-form',
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForUserTestcase(req.params.userName, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

// Delete test case //

const deleteTestcase = async (req, res, next) => {
  if (await controller.isTestcase(req.testcaseKeyPrefix, req.testcaseID)) {
    await controller.deleteTestcase(req.testcaseKey)
    res.sendStatus(200)
  } else {
    res.sendStatus(404)
  }
}

testcaseRoutes.delete('/testcases/:testcaseID',
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(ibpsaNamespace)
    req.testcaseKey = controller.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

testcaseRoutes.delete('/testcases/:testcaseNamespace/:testcaseID',
  middleware.requireSuperUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(req.params.testcaseNamespace)
    req.testcaseKey = controller.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

testcaseRoutes.delete('/users/:userName/testcases/:testcaseID',
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = controller.getPrefixForUserTestcase(req.params.userName)
    req.testcaseKey = controller.getKeyForUserTestcase(req.params.userName, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

// POST test case select //

const select = async (req, res, next) => {
  let username = undefined
  if (req.account) {
    username = req.account.name
  }
  res.json(await controller.select(req.testcaseKey, username))
}

testcaseRoutes.post('/testcases/:testcaseID/select', 
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  select
);

testcaseRoutes.post('/testcases/:testcaseNamespace/:testcaseID/select',
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  select
);

testcaseRoutes.post('/users/:userName/testcases/:testcaseID/select',
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForUserTestcase(req.params.userName, req.params.testcaseID)
    next()
  },
  select
);

// Get testcases //

const getTestcases = async (req, res, next) => {
  res.json(await controller.getTestcases(req.testcaseKeyPrefix))
}

testcaseRoutes.get('/testcases', 
  (req, res, next) => {
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(ibpsaNamespace)
    next()
  },
  getTestcases
)

testcaseRoutes.get('/testcases/:testcaseNamespace',
  (req, res, next) => {
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(req.params.testcaseNamespace)
    next()
  },
  getTestcases
)

testcaseRoutes.get('/users/:userName/testcases',
  middleware.requireUser,
  (req, res, next) => {
    req.testcaseKeyPrefix = controller.getPrefixForUserTestcase(req.params.userName)
    next()
  },
  getTestcases
)

export default testcaseRoutes;

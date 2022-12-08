import express from 'express';
import got from 'got';
import * as controller from '../controllers/testcase'

const dashboardServer = process.env.BOPTEST_DASHBOARD_SERVER
const superUsers = process.env.BOPTEST_SUPER_USERS || ""
const superUserEmails = superUsers.split(',')
const authorizedRoutes = express.Router()
const ibpsaNamespace = 'ibpsa'
const bucket = process.env.BOPTEST_S3_BUCKET

// Middleware to provide client information.
// This will increase the response time, so use it only on APIs that
// are not invoked at high frequency. (e.g. avoid using it for APIs
// such as advance which are typically within a tight simulation loop.)
const identify = async (req, res, next)  => {
  const key = req.header('Authorization');

  if (key && dashboardServer) {
    // Authorization is not mandatory for every route,
    // however if a key is provided and it is invalid then
    // return an error to the client.
    const url = dashboardServer + '/api/accounts/info'
    try {
      const body = await got.get(url, {
        headers: {
          Authorization: key
        }
      }).json()
      req.account = body
    } catch(error) {
      res.sendStatus(401)
      return
    }
  }
  next()
};

const requireSuperUser = (req, res, next) => {
  if (req.account && superUserEmails.includes(req.account.email)) {
    next()
  } else {
    res.sendStatus(401)
  }
}

const requireUser = (req, res, next) => {
  if (req.account && req.params.userName && (req.params.userName === req.account.name)) {
    next()
  } else {
    res.sendStatus(401)
  }
}

authorizedRoutes.use(identify)

const s3url = (req) => {
  // Goofy logic to consider if s3 is the real amazon service,
  // or running in a container. Reconsider this nonsense... Review Alfalfa approach.
  let s3url = null
  if ( process.env.BOPTEST_INTERNAL_S3_URL.indexOf("amazonaws") == -1 ) {
    if (req.hostname.indexOf("web") == -1 ) {
      s3url = 'http://' + req.hostname + ':9000/' + bucket
    } else {
      s3url = 'http://minio:9000/alfalfa'
    }
  }
  return s3url
}

// GET test case post-form //

const getTestcasePostForm = async (req, res, next) => {
  res.json(await controller.getTestcasePostForm(req.testcaseKey, s3url(req)))
}

authorizedRoutes.get('/testcases/:testcaseID/post-form',
  requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

authorizedRoutes.get('/testcases/:testcaseNamespace/:testcaseID/post-form',
  requireSuperUser,
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  getTestcasePostForm
)

authorizedRoutes.get('/users/:userName/testcases/:testcaseID/post-form',
  requireUser,
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

authorizedRoutes.delete('/testcases/:testcaseID',
  requireSuperUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(ibpsaNamespace)
    req.testcaseKey = controller.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

authorizedRoutes.delete('/testcases/:testcaseNamespace/:testcaseID',
  requireSuperUser,
  (req, res, next) => {
    req.testcaseID = req.params.testcaseID
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(req.params.testcaseNamespace)
    req.testcaseKey = controller.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  deleteTestcase
)

authorizedRoutes.delete('/users/:userName/testcases/:testcaseID',
  requireUser,
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
  res.json(await controller.select(req.testcaseKey))
}

authorizedRoutes.post('/testcases/:testcaseID/select', 
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(ibpsaNamespace, req.params.testcaseID)
    next()
  },
  select
);

authorizedRoutes.post('/testcases/:testcaseNamespace/:testcaseID/select',
  (req, res, next) => {
    req.testcaseKey = controller.getKeyForTestcase(req.params.testcaseNamespace, req.params.testcaseID)
    next()
  },
  select
);

authorizedRoutes.post('/users/:userName/testcases/:testcaseID/select',
  requireUser,
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

authorizedRoutes.get('/testcases', 
  (req, res, next) => {
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(ibpsaNamespace)
    next()
  },
  getTestcases
)

authorizedRoutes.get('/testcases/:testcaseNamespace',
  (req, res, next) => {
    req.testcaseKeyPrefix = controller.getPrefixForTestcase(req.params.testcaseNamespace)
    next()
  },
  getTestcases
)

authorizedRoutes.get('/users/:userName/testcases',
  requireUser,
  (req, res, next) => {
    req.testcaseKeyPrefix = controller.getPrefixForUserTestcase(req.params.userName)
    next()
  },
  getTestcases
)

export default authorizedRoutes;

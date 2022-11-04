import express from 'express';
import got from 'got';
import * as controller from '../controllers/testcase'

const dashboardServer = process.env.BOPTEST_DASHBOARD_SERVER
const authorizedRoutes = express.Router()

// Middleware to provide client information.
// This will increase the response time, so use it only on APIs that
// are not invoked at high frequency. (e.g. avoid using it for APIs
// such as advance which are typically within a tight simulation loop.)
const authorizer = async (req, res, next)  => {
  const key = req.header('Authorization');

  if (key && dashboardServer) {
    // Authorization is not mandatory for every route,
    // however if a key is provided and it is invalid then
    // return an error to the client.
    const url = dashboardServer + '/api/accounts/info'
    try {
      const {body} = await got.get(url, {
        headers: {
          Authorization: key
        }
      })
      req.userID = body.sub
    } catch(error) {
      res.sendStatus(401)
      return
    }
  }
  next()
};

// Middleware to require a valid user
// This should be used after the authorizer
const myAuth = (req, res, next) => {
  if (! req.userID) {
    res.sendStatus(401)
    return
  }
  next()
}

authorizedRoutes.use(authorizer)
authorizedRoutes.use('/my/*', myAuth)

const s3url = (req) => {
  // Goofy logic to consider if s3 is the real amazon service,
  // or running in a container. Reconsider this nonsense... Review Alfalfa approach.
  let s3url = null
  if ( process.env.S3_URL.indexOf("amazonaws") == -1 ) {
    if (req.hostname.indexOf("web") == -1 ) {
      s3url = 'http://' + req.hostname + ':9000/' + process.env.S3_BUCKET
    } else {
      s3url = 'http://minio:9000/alfalfa'
    }
  }
}

const getTestcasePostForm = async (req, res, next, userID) => {
  try {
    const id = req.params.id
    res.json(await controller.getTestcasePostForm(id, s3url(req), userID))
  } catch (e) {
    next(e)
  }
}

authorizedRoutes.get('/testcases/:id/post-form', async (req, res, next) => {
  getTestcasePostForm(req, res, next)
})

authorizedRoutes.get('/my/testcases/:id/post-form', async (req, res, next) => {
  getTestcasePostForm(req, res, next, req.userID)
})

const removeTestcase = async (req, res, next, userID) => {
  try {
    const id = req.params.id
    await controller.removeTestcase(id, userID)
    res.sendStatus(200)
  } catch (e) {
    next(e)
  }
}

authorizedRoutes.delete('/testcases/:id', async (req, res, next) => {
  removeTestcase(req, res, next)
})

authorizedRoutes.delete('/my/testcases/:id', async (req, res, next) => {
  removeTestcase(req, res, next, req.userID)
})

const select = async (req, res, next, userID) => {
  try {
    const testcaseid = req.params.testcaseid
    res.json(await controller.select(testcaseid, userID))
  } catch (e) {
    next(e)
  }
}

authorizedRoutes.post('/testcases/:testcaseid/select', async (req, res, next) => {
  select(req, res, next)
});

authorizedRoutes.post('/my/testcases/:testcaseid/select', async (req, res, next) => {
  select(req, res, next, req.userID)
});

const getTestcases = async (req, res, next, userID) => {
  try {
    res.json(await controller.getTestcases(userID))
  } catch (e) {
    next(e);
  }
}

authorizedRoutes.get('/testcases', async (req, res, next) => {
  getTestcases(req, res, next)
})

authorizedRoutes.get('/my/testcases', async (req, res, next) => {
  getTestcases(req, res, next, req.userID)
})

const isTestcase = async (req, res, next, userID) => {
  try {
    const testcaseid = req.params.testcaseid
    if (await controller.isTestcase(testcaseid, userID)) {
      res.sendStatus(200)
    } else {
      res.sendStatus(404)
    }
  } catch (e) {
    next(e);
  }
}

authorizedRoutes.get('/testcases/:testcaseid', async (req, res, next) => {
  isTestcase(req, res, next)
})

authorizedRoutes.get('/my/testcases/:testcaseid', async (req, res, next) => {
  isTestcase(req, res, next, req.userID)
})

export default authorizedRoutes;

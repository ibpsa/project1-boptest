import express from 'express';
import got from 'got';
import {
  getTestcasePostForm,
  removeTestcase,
  isTestcase,
  getTestcases,
  select
} from '../controllers/testcase';

const dashboardServer = process.env.BOPTEST_DASHBOARD_SERVER
const authorizedRoutes = express.Router()

// Middleware to provide client information.
// This will increase the response time, so use it only on APIs that
// are not invoked at high frequency. (e.g. avoid using it for APIs
// such as advance which are typically within a tight simulation loop.)
export async function authorizer(req, res, next) {
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
      res.status(401).json({error: 'Not Authorized'})
      return
    }
  }
  next()
};

authorizedRoutes.use(authorizer)

authorizedRoutes.get('/testcases/:id/post-form', async (req, res, next) => {
  try {
    const id = req.params.id

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

    const form = await getTestcasePostForm(id, s3url)
    res.send(JSON.stringify(form))
  } catch (e) {
    next(e)
  }
})

authorizedRoutes.delete('/testcases/:id', async (req, res, next) => {
  try {
    const id = req.params.id
    await removeTestcase(id)
    res.sendStatus(200)
  } catch (e) {
    next(e)
  }
})

authorizedRoutes.post('/testcases/:testcaseid/select', 
  async (req, res, next) => {
  try {
    const testcaseid = req.params.testcaseid
    const api_key = req.body['api_key'] || null
    const response = await select(testcaseid, api_key)
    return res.json(response)
  } catch (e) {
    next(e)
  }
});

authorizedRoutes.get('/testcases', async (req, res, next) => {
  try {
    const payload = await getTestcases()
    res.json(payload)
  } catch (e) {
    next(e);
  }
})

authorizedRoutes.get('/testcases/:testcaseid', async (req, res, next) => {
  try {
    const testcaseid = req.params.testcaseid
    if (await isTestcase(testcaseid)) {
      res.sendStatus(200)
    } else {
      res.sendStatus(404)
    }
  } catch (e) {
    next(e);
  }
})

export default authorizedRoutes;

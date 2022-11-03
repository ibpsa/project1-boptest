import express from 'express';
import {
  getTestcasePostForm,
  removeTestcase,
  isTestcase,
  getTestcases,
  select
} from '../controllers/testcase';

const authorizedRoutes = express.Router();

authorizedRoutes.get('/testcases/:id/post-form', async (req, res, next) => {
  try {
    const s3 = req.app.get('s3')
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

    const form = await getTestcasePostForm(id, s3, s3url)
    res.send(JSON.stringify(form));
  } catch (e) {
    next(e)
  }
})

authorizedRoutes.delete('/testcases/:id', async (req, res, next) => {
  try {
    const id = req.params.id
    const s3 = req.app.get('s3')
    await removeTestcase(id, s3)
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
    const sqs = req.app.get('sqs')
    const response = await select(testcaseid, sqs, api_key)
    return res.json(response)
  } catch (e) {
    next(e)
  }
});

authorizedRoutes.get('/testcases', async (req, res, next) => {
  try {
    const s3 = req.app.get('s3')
    const payload = await getTestcases(s3)
    res.json(payload)
  } catch (e) {
    next(e);
  }
})

authorizedRoutes.get('/testcases/:testcaseid', async (req, res, next) => {
  try {
    const s3 = req.app.get('s3')
    const testcaseid = req.params.testcaseid
    if (await isTestcase(testcaseid, s3)) {
      res.sendStatus(200)
    } else {
      res.sendStatus(404)
    }
  } catch (e) {
    next(e);
  }
})

export default authorizedRoutes;

import express from 'express';
import {
  getTestcasePostForm,
  createOrUpdateTestcase
} from '../controllers/testcase';

const boptestAdminRouter = express.Router();

boptestAdminRouter.get('/testcases/:id/post-form', async (req, res, next) => {
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

boptestAdminRouter.put('/testcases/:id', async (req, res, next) => {
  try {
    const id = req.params.id
    const sqs = req.app.get('sqs')
    await createOrUpdateTestcase(id, sqs)
    res.sendStatus(200)
  } catch (e) {
    next(e)
  }
})

export default boptestAdminRouter;

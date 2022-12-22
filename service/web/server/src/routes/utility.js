import express from 'express'
import {getVersion} from '../controllers/utility'

const utilityRoutes = express.Router()

utilityRoutes.get('/version', async (req, res, next) => {
  try {
    const payload = await getVersion()
    res.status(payload.status).json(payload)
  } catch (e) {
    next(e)
  }
})

export default utilityRoutes;

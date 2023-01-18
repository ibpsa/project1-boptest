import express from 'express'
import bodyParser from 'body-parser'
import boptestRoutes from './routes/boptestRoutes'
import { createServer } from 'http'
import { createBoptestWS } from './ws/boptestWS'

const app = express()
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use('/', boptestRoutes)

const server = createServer(app)
createBoptestWS(server)

server.listen(80, () => {
  var host = server.address().address
  var port = server.address().port

  if (host.length === 0 || host === "::") host = "localhost"
  console.log('Server listening at http://%s:%s', host, port)
})

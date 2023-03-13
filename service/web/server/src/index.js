import express from 'express'
import bodyParser from 'body-parser'
import boptestRoutes from './routes/boptestRoutes'
import { errorHandler } from './routes/error'
import { parse } from 'url'
import { createServer } from 'http'
import { createBoptestWS } from './ws/boptestWS'

const app = express()
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use('/', boptestRoutes)
app.use(errorHandler)

const wss = createBoptestWS()
const server = createServer(app)

server.on('upgrade', function upgrade(request, socket, head) {
  const { pathname } = parse(request.url)

  if (pathname === '/ws') {
    wss.handleUpgrade(request, socket, head, (ws) => {
      wss.emit('connection', ws, request)
    })
  } else {
    socket.destroy()
  }
})

server.listen(80, () => {
  var host = server.address().address
  var port = server.address().port

  if (host.length === 0 || host === "::") host = "localhost"
  console.log('Server listening at http://%s:%s', host, port)
})

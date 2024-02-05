import express from 'express'
import boptestRoutes from './routes/boptestRoutes'
import { errorHandler } from './routes/error'
import { parse } from 'url'
import { createServer } from 'http'
import { createBoptestWS } from './ws/boptestWS'

const app = express()

// app.use(express.json())
// It would be best to use express.json, however for now we need to support
// non standard keywords (Infinity / -Infinity) in the json body.
//
// express.raw extracts the body without json parsing
app.use(express.raw({ type: 'application/json' }))
// Then use custom json parsing to handle Infinity
// The solution here is to just quote the Infinity keyword,
// allowing the string to pass through to the boptest library
app.use((req, res, next) => {
  if (req.is('application/json')) {
    let body = req.body.toString()
    body = body.replaceAll(' -Infinity', ' "-Infinity"')
    body = body.replaceAll(' Infinity', ' "Infinity"')
    req.body = JSON.parse(body)
  }
  next()
})

app.use(express.urlencoded({ extended: true }))
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

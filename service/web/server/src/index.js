import express from 'express'
import bodyParser from 'body-parser'
import boptestRoutes from './routes/boptestRoutes'

var app = express()

app.use(bodyParser.urlencoded())
app.use(bodyParser.json())
app.use('/', boptestRoutes)

let server = app.listen(80, () => {
  var host = server.address().address
  var port = server.address().port

  if (host.length === 0 || host === "::") host = "localhost"
  console.log('Server listening at http://%s:%s', host, port)
})

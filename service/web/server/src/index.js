import express from 'express'
import bodyParser from 'body-parser'
import testcaseRoutes from './routes/testcase'
import testRoutes from './routes/test'
import utilityRoutes from './routes/utility'

var app = express()

app.use(bodyParser.urlencoded())
app.use(bodyParser.json())
app.use('/', testcaseRoutes)
app.use('/', testRoutes)
app.use('/', utilityRoutes)

let server = app.listen(80, () => {
  var host = server.address().address
  var port = server.address().port

  if (host.length === 0 || host === "::") host = "localhost"
  console.log('Server listening at http://%s:%s', host, port)
})

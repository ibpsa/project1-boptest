import { WebSocketServer } from 'ws'
import messaging from '../lib/messaging'
import { isTest } from '../lib/boptestLib'

async function processRequest(request, ws) {
  const requestid = request.requestid
  const testid = request.testid
  const method = request.method
  const params = request.params

  let response = { 'responseid': requestid, 'responsedata': undefined }

  if (!(requestid && testid && method && params)) {
    response.responsedata = { "status": 400, "message": "Bad Request", "payload": "Missing required attributes" }
    ws.send(JSON.stringify(response))

    return
  }

  if (!await isTest(testid)) {
    response.responsedata = { "status": 400, "message": "Bad Request", "payload": `Testid '${testid}' is not a valid test` }
    ws.send(JSON.stringify(response))

    return
  }

  try {
    response.responsedata = await messaging.callWorkerMethod(testid, method, params)
    ws.send(JSON.stringify(response))
  } catch (e) {
    response.responsedata = { "status": 500, "message": "Internal Server Error", "payload": e.message }
    ws.send(JSON.stringify(response))
  }
}

async function onMessage(data, ws) {
  let parsedData = []

  try {
    parsedData = JSON.parse(data)
  } catch (e) {
    const responsedata = { "status": 400, "message": "Bad Request", "payload": "Invalid message syntax" }
    const response = { 'responseid': undefined, 'responsedata': responsedata }
    ws.send(JSON.stringify(response))

    return
  }

  // Ensure the data is contained within an array,
  // because clients are allowed to send multiple requests
  // in a single message.
  if (!Array.isArray(parsedData)) {
    parsedData = [parsedData]
  }

  for (let request of parsedData) {
    processRequest(request, ws)
  }
}

export function createBoptestWS() {
  const wss = new WebSocketServer({ noServer: true })

  wss.on('connection', (ws) => {
    ws.on('message', (data) => {
      onMessage(data, ws)
    })

    ws.on('error', console.error)
  })

  return wss
}

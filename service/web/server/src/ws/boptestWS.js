import { WebSocketServer } from 'ws'
import messaging from '../lib/messaging'

async function processRequest(request, ws) {
  try {
    const requestid = request.requestid
    const testid = request.testid
    const method = request.method
    const params = request.params
    
    if (requestid && testid && method && params) {
      let response = {}
      response.responsedata = await messaging.callWorkerMethod(testid, method, params)
      response.responseid = requestid
      ws.send(JSON.stringify(response))
    } else {
      const errorResponse = {'responseid': requestid, 'error': 'Invalid request'}
      ws.send(JSON.stringify(errorResponse))
    }
  } catch (e) {
    const errorResponse = {'responseid': requestid, 'error': e.message}
    ws.send(JSON.stringify(errorResponse))
  }
}

async function onMessage(data, ws) {
  try {
    let parsedData = JSON.parse(data)

    // Ensure the data is contained within an array,
    // because clients are allowed to send multiple requests
    // in a single message.
    if (! Array.isArray(parsedData)) {
      parsedData = [parsedData]
    }

    for (let request of parsedData) {
      processRequest(request, ws)
    }

  } catch (e) {
    if (e instanceof SyntaxError) {
      // A SyntaxError will be caught if data from client is not valid JSON
      ws.send(e.message)
    } else {
      console.log(e)
    }
  }
}

export function createBoptestWS(server) {
  const wss = new WebSocketServer({ server })
  
  wss.on('connection', (ws) => {
    ws.on('message', (data) => {
      onMessage(data, ws)
    })
  })
}

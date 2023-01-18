import { WebSocketServer } from 'ws'
import messaging from '../lib/messaging'

async function processMethod(method, ws) {
  try {
    const testid = method.testid
    const methodName = method.method
    const params = method.params
    
    if (testid && methodName && params) {
      const response = await messaging.callWorkerMethod(testid, methodName, params)
      ws.send(response)
    } else {
      ws.send(`Invalid: ${JSON.stringify(method)}`)
    }
  } catch (e) {
    ws.send(e.message)
  }
}

async function onMessage(data, ws) {
  try {
    let parsedData = JSON.parse(data)

    // Ensure the data is contained within an array,
    // because clients are allowed to send multiple method requests
    // in a single message.
    if (! Array.isArray(parsedData)) {
      parsedData = [parsedData]
    }

    for (let method of parsedData) {
      processMethod(method, ws)
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

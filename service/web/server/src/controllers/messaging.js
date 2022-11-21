import node_redis from 'redis'
import {promisify} from 'util'
import { v4 as uuidv4 } from 'uuid'
import { pack, unpack } from 'msgpackr'

class Messaging {
  constructor() {
    this.client = node_redis.createClient({host: process.env.REDIS_HOST, detect_buffers: true, return_buffers: true})
    this.pubclient = this.client.duplicate()
    this.subclient = this.client.duplicate()
    this.subTimeoutTime = 180000
    this.responseTimeoutTime = 120000

    this.hget = promisify(this.client.hget).bind(this.client)
    this.hexists = promisify(this.client.hexists).bind(this.client)
    this.hlen = promisify(this.client.hlen).bind(this.client)
    this.hkeys = promisify(this.client.hkeys).bind(this.client)
    this.hset = promisify(this.client.hset).bind(this.client)

    this.subscriptionTimers = {}
    this.messageHandlers = {}

    this.subclient.on('message', (channel, message) => this.onMessage(channel, message))
  }

  // This function calls a remote worker method, and then waits for a reply.   
  //
  // The following steps are involved.
  // 1. A message is published on the redis channel <workerID>:request
  //    signaling a request to the worker for data. The type of data is identified by `method`.
  //    Any `params` necessary to compute the requested data are included in the message.
  // 2. The worker listens for data requests on the redis request channel, `method` is mapped to a 
  //    to a worker method, and the method is called with the given parameters.
  // 4. The worker publishes a message on the redis channel <workerID>:response,
  //    with the response data
  // 5. The callWorkerMethod function resolves a returned Promise with the retrieved data
  callWorkerMethod(workerID, method, params) {
    return new Promise((resolve, reject) => {
      let responseTimeout
      const requestChannel = workerID + ':request'
      const responseChannel = workerID + ':response'
      const requestID = uuidv4()

      this.messageHandlers[requestID] = async (parsedMessage) => {
        clearTimeout(responseTimeout)
        resolve(parsedMessage.payload)
      }

      this.subscribe(responseChannel)
      this.sendWorkerMessage(requestChannel, requestID, method, params)
      responseTimeout = setTimeout(() => {
        reject(`Timeout while sending command '${method}' to '${workerID}'`)
      }, this.responseTimeoutTime)
    })
  }

  sendWorkerMessage(channel, requestID, method, params) {
    const message = {
      'requestID': requestID,
      'method': method,
      'params': params
    }

    this.pubclient.publish(channel, pack(message))
  }

  // on any message from the subscribed channels
  // We expect a message from workers that is JSON parsable,
  // any other unexpected messages would trigger an exception
  onMessage(channel, message) {
    try {
      const parsedMessage = unpack(message)
      const requestID = parsedMessage.requestID
      const handler = this.messageHandlers[requestID]

      if (handler) {
        handler(parsedMessage)
        delete this.messageHandlers[requestID]
      }
    } catch (e) {
      console.log(e)
    }
  }

  // Subscribe to a channel with a timeout for inactivity
  // If already subscribed just reset the timer - no need to subscribe again
  subscribe(channel) {
    let timeout = this.subscriptionTimers[channel]
    if (timeout) {
      clearTimeout(timeout)
    } else {
      this.subclient.subscribe(channel)
    }
    this.subscriptionTimers[channel] = setTimeout(() => this.unsubscribe(channel), this.subTimeoutTime)
  }

  // Unsubscribe from channel and remove the timer
  unsubscribe(channel) {
    clearTimeout(this.subscriptionTimers[channel])
    delete this.subscriptionTimers[channel]
    this.subclient.unsubscribe(channel)
  }
}

const messaging = new Messaging()
export default messaging

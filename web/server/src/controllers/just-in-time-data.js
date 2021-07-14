// This function sends a request to the worker for data,
// and then waits for a reply. The worker is responsible for
// generating the data on demand and sending it back to the client
//
// Using this function, data that requires heavy computation by the worker,
// is only generated when requested. Examples of this type of data, are kpis and results history
//
// The following steps are involved.
// 1. A message is published on the redis channel <simulation id>:<dataname>:request
//    signaling a request to the worker for data. The type of data is identified by dataname.
//    Any parameters necessary to compute the requested data are included in the message.
// 2. The worker listens for data requests on the redis request channel, dataname is mapped to a 
//    type of data (results, kpi, etc), and the worker computes the requested data, potentially using
//    any given parameters included with the message necessary to computer the data requested
// 3. The worker writes the requested data to a redis hash identified by <simulation id>:<dataname>
// 4. The worker publishes a message on the redis channel <simulation id>:<dataname>:response,
//    indicating that the data is available
// 5. The getWorkerData function resolves a returned Promise with the retrieved data
export function getWorkerData(id, dataname, redis, params) {
  return new Promise((resolve, reject) => {
    let sub = redis.duplicate()
    let pub = redis.duplicate()
    let timeout

    const cleanup = () => {
      clearTimeout(timeout)
      sub.unsubscribe()
      sub.quit()
      pub.quit()
    }

    sub.on('message', (channel, message) => {
      if (message == 'ready') {
        redis.hget(id, dataname, (err, redisres) => {
          cleanup()
          if (err) {
            reject(err)
          } else {
            resolve(redisres);
          }
        })
      }
    });

    timeout = setTimeout(() => {
      cleanup()
      reject("getWorkerData timed out for: ", dataname)
    }, 30000)

    sub.subscribe(responseChannel(id, dataname))
    const stringy_params = JSON.stringify(params)
    pub.publish(requestChannel(id, dataname), stringy_params)
  })
}

function responseChannel(id, dataname) {
  return id + ":" + dataname + ":response"
}

function requestChannel(id, dataname) {
  return id + ":" + dataname + ":request"
}

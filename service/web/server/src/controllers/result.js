
function responseChannel(id) {
  return id + ":results:response"
}

function requestChannel(id) {
  return id + ":results:request"
}

export function getResults(id, point_name, start_time, final_time, redis) {
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
        redis.hget(id, 'results', (err, redisres) => {
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
      reject("No results available")
    }, 10000)

    sub.subscribe(responseChannel(id))
    const data = JSON.stringify({point_name, start_time, final_time})
    pub.publish(requestChannel(id), data)
  })
}

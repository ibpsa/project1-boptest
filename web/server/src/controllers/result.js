
function responseChannel(id) {
  return id + ":results:response"
}

function requestChannel(id) {
  return id + ":results:request"
}

export function getResults(id, name, start_time, end_time, redis) {
  return new Promise((resolve, reject) => {
    let sub = redis.duplicate()
    let pub = redis.duplicate()
    let interval

    cleanup = () => {
      clearInterval(interval)
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
        }
      }
    });

    interval = setTimeout(() => {
      cleanup()
      reject("No results available")
    }, 10000)

    sub.subscribe(responseChannel(id))
    pub.publish(requestChannel(id), {name, start_time, final_time});
  }
}

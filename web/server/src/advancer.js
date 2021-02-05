class Advancer {
  // This class pertains to advancing a simulation.
  //
  // The task is to notify the simulation alfalfa_worker of a (http) request to advance the simulation,
  // After notifying the simulation alfalfa_worker of a request to advance, the webserver must
  // wait for the simulation step to complete, and only then return a response to the http client.
  //
  // A redis database is used as the primary mechanism to
  // communicate between the webserver and the simulation alfalfa_worker
  //
  // For each request to advance a simulation, communication involves
  // 1. A redis key of the form ${siteRef}:control which can have the value idle | advance | running
  //    A request to advance can only be fulfilled if the simulatoin is currently in idle state
  // 2. A redis notification from the webserver on the channel "siteRef" with message "advance"
  // 3. A redis notification from the alfalfa_worker on the channel "siteRef" with message "complete",
  //    signaling that the simulation is done advancing to the simulation
  constructor(redis, pub, sub) {
    this.redis = redis;
    this.pub = pub;
    this.sub = sub;
    this.handlers = {};

    this.sub.on('message', (channel, message) => {
      if (message == 'complete') {
        if (this.handlers.hasOwnProperty(channel)) {
          this.handlers[channel](message);
        }
      }
    });
  }

  advance(siteRefs) {
    let promise = new Promise((resolve, reject) => {
      let response = {};
      let pending = siteRefs.length;

      const advanceSite = (siteref) => {
        const channel = siteref;

        // Cleanup the resrouces for advance and finalize the promise
        let interval;
        const finalize = (success, message='') => {
          clearInterval(interval);
          this.sub.unsubscribe(channel);
          response[siteref] = { "status": success, "message": message };
          pending = pending - 1;
          if (pending == 0) {
            resolve(JSON.stringify(response));
          }
        };

        const notify = () => {
          this.handlers[channel] = () => {
            finalize(true, 'success');
          };

          this.sub.subscribe(channel);
          this.pub.publish(channel, "advance");

          // This is a failsafe if for some reason we miss a notification
          // that the step is complete
          // Check if the simulation has gone back to idle
          let intervalCounts = 0;
          interval = setInterval(() => {
            const control = this.redis.hget(siteref, 'control', (err, control) => {
              if (err) {
                finalize(false, 'no simulation reply');
              }
              if (control == 'idle') {
                // If the control state is idle, then assume the step has been made
                // and reslve the advance promise, this might happen if we miss the notification for some reason
                finalize(true, 'success');
              } else {
                intervalCounts += 1;
              }
              if (intervalCounts > 4) {
                finalize(false, 'no simulation reply');
              }
            });
          }, 500);
        };

        // Put siteref:control key into "advance" state
        this.redis.watch(siteref, (err) => {
          if (err) throw err;

          this.redis.hget(siteref, 'control', (err, control) => {
            if (err) throw err;
            // if control not equal idle then abort the request to advance and return to client
            if (control == 'idle') {
              // else proceed to advance state, this node has exclusive control over the simulation now
              this.redis.multi()
                .hset(siteref, "control", "advance")
                .exec((err, results) => {
                  if (err) throw err;
                  notify();
                })
            } else {
              finalize(true, 'busy');
            }
          });
        });
      };

      for (var site of siteRefs) {
        advanceSite(site);
      }
    });

    return promise;
  }
}

export {Advancer};

import {addJobToQueue} from './job';

function promiseTaskLater(task, time, ...args) {
  return new Promise((resolve, reject) => {
    setTimeout(async () => {
      try {
        await task(...args);
        resolve();
      } catch (e) {
        reject(e);
      }
    }, time);
  });
};

function setU(site_ref, u, redis) {
  return new Promise((resolve, reject) => {
    redis.hset(site_ref, 'u', JSON.stringify(u), (err) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

function sendStopSignal(site_ref, pub) {
  pub.publish(site_ref, "stop");
}

export function simStatus(site_ref, redis) {
  return new Promise((resolve, reject) => {
    redis.hget(site_ref, 'status', (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
};

export async function waitForStatus(id, redis, desiredStatus, count, maxCount) {
  let i = 0;
  const currentStatus = await simStatus(id, redis);
  if (currentStatus == desiredStatus) {
    return;
  } else if (count == maxCount) {
    throw(`Timeout waiting for test: ${id} to reach status: ${desiredStatus}`);
  } else {
    await promiseTaskLater(waitForStatus, 2000, id, redis, desiredStatus, count, maxCount);
  }
};

export function setStatus(site_ref, stat, redis) {
  return new Promise((resolve, reject) => {
    redis.hset(site_ref, 'status', stat, (err) => {
      if (err) {
        reject(err)
      } else {
        resolve()
      }
    })
  })
}

export function getY(site_ref, redis) {
  return new Promise((resolve, reject) => {
    redis.hget(site_ref, 'y', (err, data) => {
      if (err) {
        reject(err)
      } else {
        resolve(data)
      }
    })
  })
}

export async function initialize(site_ref, start_time, warmup_period, redis, sqs) {
  await setStatus(site_ref, "Starting", redis)
  await addJobToQueue("runSite", sqs, {site_ref, start_time, warmup_period})
  await waitForStatus(site_ref, redis, "Running", 0, 3)
  return await getY(site_ref, redis)
}

export async function advance(site_ref, redis, advancer, u) {
  await setU(site_ref, u, redis)
  await advancer.advance([site_ref])
  return await getY(site_ref, redis)
}

export async function stop(site_ref, redis, pub) {
  const stat = await simStatus(site_ref, redis)
  if (stat == "Running") {
    await setStatus(site_ref, "Stopping", redis)
    sendStopSignal(site_ref, pub)
    await waitForStatus(site_ref, redis, "Stopped", 0, 3)
  }
}


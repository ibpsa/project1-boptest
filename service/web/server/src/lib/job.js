import redis from '../redis'

export async function addJobToQueue(jobtype, params) {
  let job = {
    jobtype,
    params
  }

  await redis.rpush('jobs', JSON.stringify(job))
}

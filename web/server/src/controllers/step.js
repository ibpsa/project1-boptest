
export async function getStep(site_ref, db, redis) {
  return new Promise((resolve, reject) => {
    // Look in redis first for a cached value,
    // running tests should have a cached value.
    // Fallback to the testcase default from database
    redis.hget(site_ref, 'step', async (err, res) => {
      if (err) {
        reject(err);
      } else {
        if (res) {
          resolve(res)
        } else {
          try {
            const testcases = db.collection('testcases')
            const query = {site_ref}
            const doc = await testcases.findOne(query)
            resolve(doc.step)
          } catch (e) {
            reject(e)
          }
        }
      }
    })
  })
}

export async function setStep(site_ref, step, db, redis) {
  return new Promise((resolve, reject) => {
    redis.hset(site_ref, 'step', step, async (err) => {
      if (err) {
        reject(err)
      } else {
        try {
          const testcases = db.collection('testcases')
          const query = {site_ref}
          const update = { $set: { step } }
          const options = {}
          await testcases.updateOne(query, update, options)
          resolve()
        } catch (e) {
          reject(e)
        }
      }
    })
  })
}


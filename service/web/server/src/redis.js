import node_redis from 'redis'
import { promisify } from 'util'

let redis = {}

redis.client = node_redis.createClient({ host: process.env.BOPTEST_REDIS_HOST, return_buffers: true })
redis.pubclient = redis.client.duplicate()
redis.subclient = redis.client.duplicate()

redis.del = promisify(redis.client.del).bind(redis.client)
redis.hget = promisify(redis.client.hget).bind(redis.client)
redis.hgetall = promisify(redis.client.hgetall).bind(redis.client)
redis.hexists = promisify(redis.client.hexists).bind(redis.client)
redis.hlen = promisify(redis.client.hlen).bind(redis.client)
redis.hkeys = promisify(redis.client.hkeys).bind(redis.client)
redis.hset = promisify(redis.client.hset).bind(redis.client)
redis.hdel = promisify(redis.client.hdel).bind(redis.client)
redis.exists = promisify(redis.client.exists).bind(redis.client)
redis.sadd = promisify(redis.client.sadd).bind(redis.client)
redis.srem = promisify(redis.client.srem).bind(redis.client)
redis.smembers = promisify(redis.client.smembers).bind(redis.client)
redis.sscan = promisify(redis.client.sscan).bind(redis.client)
redis.rpush = promisify(redis.client.rpush).bind(redis.client)
redis.lpop = promisify(redis.client.lpop).bind(redis.client)

export default redis

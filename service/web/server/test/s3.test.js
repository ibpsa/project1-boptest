const assert = require('node:assert/strict')
const http = require('node:http')
const { after, before, test } = require('node:test')
const { pack, unpack } = require('msgpackr')

let storage
let endpoint
let server
let handleRequest

before(async () => {
  server = http.createServer((request, response) => handleRequest(request, response))
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve))
  endpoint = `http://127.0.0.1:${server.address().port}`
  process.env.BOPTEST_INTERNAL_S3_URL = endpoint
  process.env.BOPTEST_REGION = 'us-east-1'
  process.env.AWS_ACCESS_KEY_ID = 'test-access-key'
  process.env.AWS_SECRET_ACCESS_KEY = 'test-secret-key'
  delete process.env.AWS_SESSION_TOKEN
  storage = require('../build/s3')
})

after(async () => {
  server.closeAllConnections()
  await new Promise(resolve => server.close(resolve))
})

test('upload forms bind the bucket, key, and ACL to the signed policy', async () => {
  const key = 'testcases/shared/testcase1.fmu'
  const form = await storage.createUploadForm({
    Bucket: 'boptest',
    Fields: { key, acl: 'public-read' }
  })
  assert.equal(new URL(form.url).origin, endpoint)
  assert.equal(new URL(form.url).pathname, '/boptest')
  assert.equal(form.fields.key, key)
  assert.equal(form.fields.acl, 'public-read')
  assert.match(form.fields['X-Amz-Credential'], /^test-access-key\/\d{8}\/us-east-1\/s3\/aws4_request$/)
  assert.match(form.fields['X-Amz-Signature'], /^[a-f0-9]{64}$/)

  const policy = JSON.parse(Buffer.from(form.fields.Policy, 'base64').toString())
  for (const condition of [{ bucket: 'boptest' }, { key }, { acl: 'public-read' }]) {
    assert.ok(policy.conditions.some(item => JSON.stringify(item) === JSON.stringify(condition)))
  }
  const remainingSeconds = (Date.parse(policy.expiration) - Date.now()) / 1000
  assert.ok(remainingSeconds > 3500 && remainingSeconds <= 3600)
})

test('private upload forms do not grant public access', async () => {
  const form = await storage.createUploadForm({
    Bucket: 'boptest',
    Fields: { key: 'users/test-user/testcase1.fmu' }
  })
  assert.equal(form.fields.acl, undefined)
  const policy = JSON.parse(Buffer.from(form.fields.Policy, 'base64').toString())
  assert.ok(policy.conditions.every(condition => !Object.hasOwn(condition, 'acl')))
})

test('listing signs a path-style request and preserves the requested prefix', async () => {
  let received
  handleRequest = (request, response) => {
    received = request
    response.setHeader('Content-Type', 'application/xml')
    response.end('<ListBucketResult><Contents><Key>testcases/testcase1.fmu</Key><Size>10</Size></Contents></ListBucketResult>')
  }
  const result = await storage.listObjects({ Bucket: 'boptest', Prefix: 'testcases/' })
  const url = new URL(received.url, endpoint)
  assert.equal(received.method, 'GET')
  assert.equal(url.pathname, '/boptest/')
  assert.equal(url.searchParams.get('prefix'), 'testcases/')
  assert.equal(url.searchParams.get('list-type'), '2')
  assert.match(received.headers.authorization, /^AWS4-HMAC-SHA256 /)
  assert.equal(result.Contents[0].Key, 'testcases/testcase1.fmu')
})

test('object downloads preserve streamed binary MessagePack results', async () => {
  const payload = { status: 200, message: 'Success', payload: { time: [0, 60], temperature: [293.15, 294.15] } }
  const packed = pack(payload)
  let received
  handleRequest = (request, response) => {
    received = request
    response.setHeader('Content-Type', 'application/octet-stream')
    response.write(packed.subarray(0, 7))
    response.end(packed.subarray(7))
  }
  const body = await storage.getObjectBody({ Bucket: 'boptest', Key: 'tests/test one/results.msgpack' })
  assert.equal(new URL(received.url, endpoint).pathname, '/boptest/tests/test%20one/results.msgpack')
  assert.deepEqual(Buffer.from(body), packed)
  assert.deepEqual(unpack(body), payload)
})

test('object deletion supports an empty successful response', async () => {
  let received
  handleRequest = (request, response) => {
    received = request
    response.writeHead(204)
    response.end()
  }
  await storage.deleteObject({ Bucket: 'boptest', Key: 'tests/test-one/results.msgpack' })
  assert.equal(received.method, 'DELETE')
  assert.equal(new URL(received.url, endpoint).pathname, '/boptest/tests/test-one/results.msgpack')
})

for (const operation of ['listObjects', 'getObjectBody', 'deleteObject']) {
  test(`${operation} propagates storage authorization failures`, async () => {
    handleRequest = (request, response) => {
      response.writeHead(403, { 'Content-Type': 'application/xml' })
      response.end('<Error><Code>AccessDenied</Code><Message>Access Denied</Message></Error>')
    }
    await assert.rejects(
      storage[operation]({ Bucket: 'boptest', Key: 'testcases/testcase1.fmu' }),
      error => error.name === 'AccessDenied' && error.$metadata.httpStatusCode === 403
    )
  })
}

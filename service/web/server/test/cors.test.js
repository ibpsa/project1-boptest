'use strict'

// Set BOPTEST_ALLOWED_ORIGINS before the middleware module loads so that
// additionalAllowedOrigins is populated when the module-level constant is evaluated.
process.env.BOPTEST_ALLOWED_ORIGINS = 'https://custom.example.com'

const express = require('express')
const request = require('supertest')

// @babel/register (invoked via the mocha --require flag) transpiles the ES
// module syntax in middleware.js to CommonJS on the fly.
const { addCorsOriginHdr, handleCorsPreflight } = require('../src/routes/middleware')

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function makeGetApp() {
  const app = express()
  app.get('/test', (req, res) => addCorsOriginHdr(req, res, () => res.sendStatus(200)))
  return app
}

function makeOptionsApp(allowedMethods) {
  const app = express()
  app.options('/test', (req, res, next) => handleCorsPreflight(req, res, next, allowedMethods))
  return app
}

// ---------------------------------------------------------------------------
// addCorsOriginHdr
// ---------------------------------------------------------------------------

describe('addCorsOriginHdr', () => {
  it('sets Access-Control-Allow-Origin and Vary for an allowed localhost origin', () =>
    request(makeGetApp())
      .get('/test')
      .set('Origin', 'http://localhost:3000')
      .expect('Access-Control-Allow-Origin', 'http://localhost:3000')
      .expect('Vary', 'Origin')
      .expect(200)
  )

  it('sets the header for boptest.net', () =>
    request(makeGetApp())
      .get('/test')
      .set('Origin', 'https://boptest.net')
      .expect('Access-Control-Allow-Origin', 'https://boptest.net')
      .expect(200)
  )

  it('sets the header for a subdomain of boptest.net', () =>
    request(makeGetApp())
      .get('/test')
      .set('Origin', 'https://app.boptest.net')
      .expect('Access-Control-Allow-Origin', 'https://app.boptest.net')
      .expect(200)
  )

  it('sets the header for an origin from BOPTEST_ALLOWED_ORIGINS', () =>
    request(makeGetApp())
      .get('/test')
      .set('Origin', 'https://custom.example.com')
      .expect('Access-Control-Allow-Origin', 'https://custom.example.com')
      .expect(200)
  )

  it('does not set the header for a disallowed origin', () =>
    request(makeGetApp())
      .get('/test')
      .set('Origin', 'https://attacker.com')
      .expect((res) => {
        if (res.headers['access-control-allow-origin']) {
          throw new Error(`Unexpected CORS header: ${res.headers['access-control-allow-origin']}`)
        }
      })
      .expect(200)
  )

  it('does not set the header when no Origin is present', () =>
    request(makeGetApp())
      .get('/test')
      .expect((res) => {
        if (res.headers['access-control-allow-origin']) {
          throw new Error(`Unexpected CORS header: ${res.headers['access-control-allow-origin']}`)
        }
      })
      .expect(200)
  )

  it('always calls next() regardless of origin validity', () =>
    // A disallowed origin still gets a 200 because next() is called
    request(makeGetApp())
      .get('/test')
      .set('Origin', 'https://attacker.com')
      .expect(200)
  )
})

// ---------------------------------------------------------------------------
// handleCorsPreflight
// ---------------------------------------------------------------------------

describe('handleCorsPreflight', () => {
  it('responds 204 with full CORS headers for an allowed origin', () =>
    request(makeOptionsApp('GET'))
      .options('/test')
      .set('Origin', 'http://localhost:3000')
      .expect('Access-Control-Allow-Origin', 'http://localhost:3000')
      .expect('Access-Control-Allow-Methods', 'GET')
      .expect('Access-Control-Allow-Headers', 'Content-Type, Authorization')
      .expect('Access-Control-Max-Age', '86400')
      .expect('Vary', 'Origin')
      .expect(204)
  )

  it('advertises PUT for PUT-only routes', () =>
    request(makeOptionsApp('PUT'))
      .options('/test')
      .set('Origin', 'https://boptest.net')
      .expect('Access-Control-Allow-Methods', 'PUT')
      .expect(204)
  )

  it('advertises both methods for mixed GET, PUT routes', () =>
    request(makeOptionsApp('GET, PUT'))
      .options('/test')
      .set('Origin', 'https://boptest.net')
      .expect('Access-Control-Allow-Methods', 'GET, PUT')
      .expect(204)
  )

  it('responds 405 for a disallowed origin', () =>
    request(makeOptionsApp('GET'))
      .options('/test')
      .set('Origin', 'https://attacker.com')
      .expect(405)
  )

  it('responds 405 when no Origin header is present', () =>
    request(makeOptionsApp('GET'))
      .options('/test')
      .expect(405)
  )

  it('calls next() for non-OPTIONS requests so the actual handler runs', () => {
    const app = express()
    app.get('/test',
      (req, res, next) => handleCorsPreflight(req, res, next, 'GET'),
      (req, res) => res.sendStatus(200)
    )
    return request(app)
      .get('/test')
      .set('Origin', 'http://localhost:3000')
      .expect(200)
  })
})

// ---------------------------------------------------------------------------
// Origin allowlist
// ---------------------------------------------------------------------------

describe('origin allowlist', () => {
  const allowed = [
    'http://localhost:3000',
    'http://localhost:8080',
    'https://localhost:443',
    'https://boptest.net',
    'http://boptest.net',
    'https://app.boptest.net',
    'https://my.sub.boptest.net',
    'https://custom.example.com', // via BOPTEST_ALLOWED_ORIGINS
  ]

  const disallowed = [
    'https://notboptest.net',
    'https://boptest.net.evil.com',
    'https://evilboptest.net',
    'http://localhost',       // no port — does not match localhost:\d+
    'https://localhost',      // no port
    'ftp://localhost:3000',   // wrong scheme
  ]

  for (const origin of allowed) {
    it(`allows ${origin}`, () =>
      request(makeGetApp())
        .get('/test')
        .set('Origin', origin)
        .expect('Access-Control-Allow-Origin', origin)
        .expect(200)
    )
  }

  for (const origin of disallowed) {
    it(`blocks ${origin}`, () =>
      request(makeGetApp())
        .get('/test')
        .set('Origin', origin)
        .expect((res) => {
          if (res.headers['access-control-allow-origin']) {
            throw new Error(
              `Expected no CORS header for ${origin}, got: ${res.headers['access-control-allow-origin']}`
            )
          }
        })
        .expect(200)
    )
  }
})

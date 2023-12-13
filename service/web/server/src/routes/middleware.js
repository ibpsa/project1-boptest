import { validationResult } from 'express-validator'
import got from 'got'

const dashboardServer = process.env.BOPTEST_DASHBOARD_SERVER
const testUsername = process.env.BOPTEST_TEST_USERNAME
const testKey = process.env.BOPTEST_TEST_KEY
const testPrivilegedUsername = process.env.BOPTEST_TEST_PRIVILEGED_USERNAME
const testPrivilegedKey = process.env.BOPTEST_TEST_PRIVILEGED_KEY
const useTestUsers = process.env.BOPTEST_USE_TEST_USERS === 'true'

// Middleware to provide client information.
// This will increase the response time, so use it only on APIs that
// are not invoked at high frequency. (e.g. avoid using it for APIs
// such as advance which are typically within a tight simulation loop.)
export async function identify(req, res, next) {
  const key = req.header('Authorization');

  if (useTestUsers) {
    // Try to use fake test accounts if configured by environment
    if (key && (key == testKey)) {
      req.account = {
        name: testUsername,
        sub: 'abc' + testUsername + 'xyz',
        privileged: false,
      }
    } else if (key && (key == testPrivilegedKey)) {
      req.account = {
        name: testPrivilegedUsername,
        sub: 'abc' + testPrivilegedUsername + 'xyz',
        privileged: true,
      }
    }
  } else {
    if (key) {
      // Authorization is not mandatory for every route,
      // however if a key is provided and it is invalid then
      // return an error to the client.
      const url = dashboardServer + '/api/accounts/info'
      try {
        const body = await got.get(url, {
          headers: {
            Authorization: key
          }
        }).json()
        req.account = body
      } catch (err) {
        console.log(err.stack)
        res.sendStatus(401)
        return
      }
    } // if key
  }

  next()
};

export function requireSuperUser(req, res, next) {
  if (req.account && req.account.privileged) {
    next()
  } else {
    res.sendStatus(401)
  }
}

export function requireUser(req, res, next) {
  if (req.account && req.params.userName && (req.params.userName === req.account.name)) {
    next()
  } else {
    res.sendStatus(401)
  }
}

// If there is a validation error associated with the request,
// then send an appropriate response.
export function validationResponse(req, res, next) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next()
}

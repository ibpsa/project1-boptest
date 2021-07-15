import {
  getInputs,
  getTestcaseID
} from '../controllers/test';

// Validate that the parameter 'testid' is a valid test.
export async function validateTestid(param, {req}) {
  const redis = req.app.get('redis')
  // A valid test will have a testcaseid
  if (! await getTestcaseID(param, redis)) {
    throw new Error(`Invalid testid: ${param}`)
  }
  return true
}

// Validate body, such that it contains only valid control input names.
export async function validateControlInputs(body, {req}) {
  // This is a custom validator because the valid input names are
  // a dynamic value based on the test case name
  // Also, the entire body content is validated at once, rather than
  // field by field validators so that getInputs is only called once, per request
  const db = req.app.get('db')
  const redis = req.app.get('redis')
  const testid = req.params.testid
  const input_names = Object.keys(await getInputs(testid, db, redis))
  const invalid_names = []

  for (const key in body) {
    if (! input_names.includes(key) ) {
      invalid_names.push(key)
    }
  }

  if (invalid_names.length > 0) {
    throw new Error('Invalid control input: ', invalid_names.toString())
  }

  return true
}

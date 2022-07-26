import {
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

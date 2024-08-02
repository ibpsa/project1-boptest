import {
  isTest
} from '../lib/boptestLib';

// Validate that the parameter 'testid' is a valid test.
export async function validateTestid(param) {
  if (! await isTest(param)) {
    throw new Error(`Invalid testid: ${param}`)
  }
  return true
}

import {
  isTest
} from '../controllers/test';

// Validate that the parameter 'testid' is a valid test.
export async function validateTestid(testid) {
  if (await isTest(testid)) {
    return true
  } else {
    throw new Error(`Invalid testid: ${testid}`)
  }
}

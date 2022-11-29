import {
  checkTestIDExists
} from '../controllers/test';

// Validate that the parameter 'testid' is a valid test.
export async function validateMyTestid(testid, {req}) {
  // A valid test will have a testcaseid
  if (! await checkTestIDExists(testid, req.userID)) {
    throw new Error(`Invalid testid: ${testid}`)
  }
  return true
}

// Validate that the parameter 'testid' is a valid test.
export async function validateTestid(testid, {req}) {
  // A valid test will have a testcaseid
  if (! await checkTestIDExists(testid)) {
    throw new Error(`Invalid testid: ${testid}`)
  }
  return true
}
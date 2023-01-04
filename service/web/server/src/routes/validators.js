import {
  isTest
} from '../lib/boptestLib';

// Validate that the parameter 'testid' is a valid test.
export async function validateTestid(testid) {
  if (await isTest(testid)) {
    return true
  } else {
    throw new Error(`Invalid testid: ${testid}`)
  }
}

//// Validate that the parameter 'testid' is a valid test.
//export async function validateTestid(testid, {req}) {
//  // A valid test will have a testcaseid
//  if (! await checkTestIDExists(testid)) {
//    throw new Error(`Invalid testid: ${testid}`)
//  }
//  return true
//}

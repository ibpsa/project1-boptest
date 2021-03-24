
export async function getInputs(site_ref, db) {
  try {
    const inputs = db.collection('inputs')
    const query = {site_ref}
    const doc = await inputs.findOne(query)
    return doc.inputs
  } catch(e) {
    console.log(e)
  }
}

export async function getMeasurements(site_ref, db) {
  try {
    const measurements = db.collection('measurements')
    const query = {site_ref}
    const doc = await measurements.findOne(query)
    return doc.measurements
  } catch(e) {
    console.log(e)
  }
}

export async function getName(site_ref, db) {
  try {
    const testcases = db.collection('testcases')
    const query = {site_ref}
    const doc = await testcases.findOne(query)
    return doc.name
  } catch(e) {
    console.log(e)
  }
}


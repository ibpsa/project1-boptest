
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

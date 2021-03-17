
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

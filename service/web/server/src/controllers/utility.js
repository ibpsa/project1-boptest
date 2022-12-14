import { promises as fs } from "fs";

export async function getVersion() {
  const libraryVersion = (await fs.readFile('/boptest/version.txt', 'utf8')).trim()
  const serviceVersion = (await fs.readFile('/boptest/service-version.txt', 'utf8')).trim()
  
  const status = 200;
  const message = "Queried the version number successfully."
  const payload = {'version': libraryVersion, 'service-version': serviceVersion}
  return {status, message, payload}
}

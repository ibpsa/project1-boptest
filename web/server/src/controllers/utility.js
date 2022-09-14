import fs from 'fs';

export async function getVersion() {
  return new Promise((resolve, reject) => {
    fs.readFile('/boptest/version.txt', 'utf8', function (error, data) {
      if (error) {
        const status = 500;
        const message = "BOPTEST version is unknown."
        const payload = {'version': 'null'};
        resolve({status, message, payload});
      } else {
        const status = 200;
        const message = "Queried the version number successfully."
        const payload = {'version': data};
        resolve({status, message, payload});
      }
    })
  })
}

import fs from 'fs';

export async function getVersion() {
  return new Promise((resolve, reject) => {
    fs.readFile('/boptest/version.txt', 'utf8', function (error, data) {
      if (error) {
        status = 500;
        message = "BOPTEST version is unknown."
        payload = {'version': 'null'};
        resolve({status, message, payload});
      } else {
        status = 200;
        message = "Queried the version number successfully."
        payload = {'version': data};
        resolve({status, message, payload});
      }
    })
  })
}

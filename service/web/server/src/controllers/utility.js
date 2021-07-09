import fs from 'fs';

export async function getVersion() {
  return new Promise((resolve, reject) => {
    fs.readFile('/boptest/version.txt', 'utf8', function (error, data) {
      if (error) return reject(error);
      resolve({'version': data});
    })
  })
}

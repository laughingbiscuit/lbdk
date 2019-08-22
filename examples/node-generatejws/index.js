const jws = require('jws')
const fs = require('fs')

const payload = JSON.stringify({
  'example':123,
  'example4':456
})

const key = fs.readFileSync('./key.txt')
const signature = jws.sign({
  header: { alg: 'RS256' },
  payload: payload,
  privateKey: {
    key: key,
    passphrase: 'Corp123.'
  }
})

console.log(signature)

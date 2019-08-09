const apickli = require('apickli')
const {
  Before,
  setDefaultTimeout
} = require('cucumber')
const org = process.env.APIGEE_ORG
const env = process.env.APIGEE_ENV

Before(function() {
  this.apickli = new apickli.Apickli('https',
    org + '-' + env + '.apigee.net')
})

setDefaultTimeout(60 * 1000)

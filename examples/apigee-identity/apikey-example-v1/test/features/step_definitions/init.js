const apickli = require('apickli')
const {
  Before,
  setDefaultTimeout
} = require('cucumber')

Before(function() {
  this.apickli = new apickli.Apickli(
    'https', 
    process.env.APIGEE_ORG + '-' + 
    process.env.APIGEE_ENV + '.apigee.net/apikey-example/v1'
  )
  this.apickli.scenarioVariables.apikey = process.env.APIKEY
})

setDefaultTimeout(60 * 1000)

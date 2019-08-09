const ApiMocker = require('apimocker')

ApiMocker.createServer({
  port: process.env.PORT || 9000
})
  .setConfigFile('config.json')
  .start()

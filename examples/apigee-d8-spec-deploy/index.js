const program = require('commander')
const request = require('request')
const fs = require('fs')

program
  .version('0.0.1')
  .option('-L, --baseUri <uri>', 'The base URI for your Drupal 8 Installation', 'http://localhost:8080')
  .option('-u, --username <username>', 'The username of the Drupal Admin account', 'admin')
  .option('-p, --password <password>', 'The password of the Drupal Admin account', 'pass')

const deploy = (specPath) => {
  request({
    method: 'POST',
    url: program.baseUri + '/entity/apidoc',
    auth: {
      user: program.username,
      pass: program.password
    },
    json: JSON.parse(fs.readFileSync(specPath))
  }, (e, res, body) => {
    if(e) console.log(e)
    console.log(body)
  })
}

program
  .command('deploy <specPath>')
  .action(deploy)

program.parse(process.argv)

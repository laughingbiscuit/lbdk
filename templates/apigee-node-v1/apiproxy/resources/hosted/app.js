const express = require('express')
const app = express()
const port = process.env.PORT || 9000

app.get('/', (req, res) => res.json({
  success: true
}))

app.listen(port)

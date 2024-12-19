const express = require('express')
const mongoose = require('mongoose');

const app = express()
const port = 3000




app.listen(port, () => {
    console.log(`The app listening on port ${port}`)
})
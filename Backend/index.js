const express = require('express');
const mongoose = require('mongoose');
const Router = require('./Routes/api');
require('dotenv').config();

const app = express();
const port = 3000;

const uri = process.env.URI;

const connect = async () => {
    try {
        await mongoose.connect(uri);
        console.log('Connected to MongoDB');
    } catch (err) {
        console.error(err.stack);
        process.exit(1);
    }
};

app.use(express.json()); 
app.use('/', Router);

connect();

app.listen(port, () => {
    console.log(`The app listening on port ${port}`);
});

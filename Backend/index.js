const express = require('express');
const mongoose = require('mongoose');
const Router = require('./Routes/api');
require('dotenv').config();
const cors = require('cors');
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

app.use(express.json({
    limit: '50mb',
    extended: true
}));
app.use(express.urlencoded({
    limit: '50mb',
    extended: true
}));
app.use('/', Router);
app.use(cors());
connect();

app.listen(port, '0.0.0.0', () => {
    console.log(`The app listening on port ${port}`);
});


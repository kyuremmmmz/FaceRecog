const express = require('express');
const mongoose = require('mongoose');
const Router = require('./Routes/api');
require('dotenv').config();
const session = require('express-session');
const cookie = require('cookie-parser');
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
app.use(
    session({
        secret: process.env.SESSION_SECRET,
        resave: false,
        saveUninitialized: false,
        cookie: {
            secure: false,
            httpOnly: true,
            maxAge: 1000 * 60 * 60 * 24 * 7
        }
    })
)

app.use(cookie(process.env.SESSION_SECRET))
connect();

app.listen(port, '0.0.0.0', () => {
    console.log(`The app listening on port ${port}`);
});


const mongoose = require('mongoose');


const token = mongoose.Schema({
    token: {
        type: String,
        required: true,
        unique: true
    },
    studentID: {
        type: String,
        required: true,
        unique: true
    }
});

const Token = mongoose.model('Token', token);

module.exports = Token;
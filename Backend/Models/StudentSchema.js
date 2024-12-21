const mongoose = require('mongoose');


const student = mongoose.Schema({
    firstName: {
        type: String,
        required: true,
        validate: {
            validator: (value) => /^[a-zA-Z]+$/.test(value),
            message: 'First name must only contain alphabetical characters.'
        },
    },
    lastName: {
        type: String,
        required: true,
        validate: {
            validator: (value) => /^[a-zA-Z]+$/.test(value),
            message: 'Last name must only contain alphabetical characters.'
        },
    },
    middleInitial: {
        type: String,
        required: true,
        min: [3, 'middle initial character must be only alphanumeric characters']
    }
});

const Students = mongoose.model('Student', student);

module.exports = Students;
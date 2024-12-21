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
        },
        studentID: {
            type: String,
            required: true,
            unique: true,
        },
        block: {
            type: String,
            required: true
        },
        email: {
            type: String,
            required: true,
            unique: true,
            validate: {
                validator: (value) => /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value),
                message: 'Please enter a valid email address.'
            },
        },
        password: {
            type: String,
            required: true,
            minlength: [8, 'Password must be at least 8 characters long']
        }
    });

    const Students = mongoose.model('Student', student);

    module.exports = Students;
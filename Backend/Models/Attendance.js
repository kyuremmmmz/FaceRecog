const mongoose = require('mongoose');

const AttendanceSchema = mongoose.Schema({
    studentID: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        required: true,
        default: Date.now
    },
    present: {
        type: String,
        enum: ['present', 'absent'],
        required: true
    },
    subjectCodetAttended: {
        type: String,
        required: true
    },
});

const Attendance = mongoose.model('Attendance', AttendanceSchema);

module.exports = Attendance;
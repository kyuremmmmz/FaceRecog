const Attendance = require("../Models/Attendance");

const Attend = async (data) => {
    try {
        const { studentID, date, present, subjectCodetAttended } = data;
        const attend = new Attendance({
            studentID,
            date,
            present,
            subjectCodetAttended,
        });
            const savedData = await attend.save();
            return savedData
    } catch (e) {
        console.error('Error in Attend:', e.message);
        return null;
    }
}

module.exports = {Attend}
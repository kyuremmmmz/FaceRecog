const Students = require('../Models/StudentSchema');

const getImage = async (data) => {
    try {
        const studentID = data;
        const student = await Students.findOne({ studentID: studentID });
        if (!student) {
            console.log('404: Student not found');
            return null;
        }
        return student;
    } catch (err) {
        console.error('Error in getImage:', err.message);
        return null;
    }
}

module.exports = { getImage };
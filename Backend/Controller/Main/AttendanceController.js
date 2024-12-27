const Students = require("../../Models/StudentSchema");
const { Attend } = require("../../Services/AttendanceServices");

exports.AttendanceController = async (req, res, next) => {
    try {
        const data1 = req.body;
        const data = await Attend(data1);
        const studentID = req.body.studentID;
        const studentid = await Students.findOne({ studentID: studentID });
        if (!studentid) {
            res.status(404).json({
                message: 'Student not found'
            });
        }
        res.status(201).json({
            message: "Attendance recorded successfully",
            data: data
        });
    } catch (e) {
        res.status(500).json({
            message: "An error occurred while recording attendance",
            error: e.message
        });
     }
}
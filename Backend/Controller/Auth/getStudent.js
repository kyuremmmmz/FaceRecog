const { getImage } = require("../../Services/getImage");

exports.getImage = async (req, res, next) => {
    try {
        const studentID = await req.body.studentID;
        const student = await getImage(studentID);
        if (!student) {
            return res.status(404).json({
                message: "Student not found"
            });
        }
        res.status(200).json({
            message: "Image retrieved successfully",
            student: student
        });
    }catch (err) {
        console.error('Error:', err.message);
        res.status(500).json({
            message: "An error occurred while getting the image",
            error: err.message
        });
        next(err);
    }
 }
const Students = require('../Models/StudentSchema');
const bycrypt = require('bcrypt')

const Register = async (data) => {
    try {
        

    const { firstName, lastName, middleInitial, studentID, block, email, password, imagePath } = data;

        const hashPass = await bycrypt.hash(password, 10);

        const user = new Students({
            firstName,
            lastName,
            middleInitial,
            studentID,
            block,
            email,
            imagePath,
            password: hashPass
        });

        const userData = await user.save();
        return userData;
    } catch (e) {
        console.error('Error registering student', e);
        throw e;
    }
};



module.exports = { Register };
const Students = require('../Models/StudentSchema');
const bycrypt = require('bcrypt')

const Register = async (data) => {
    try {
        

    const { firstName, lastName, middleName, studentD, yearBlock, email, password } = data;

        const hashPass = await bycrypt.hash(password, 10);

        const user = new Students({
            firstName,
            lastName,
            middleInitial: middleName,
            studentID: studentD,
            block: yearBlock,
            email,
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
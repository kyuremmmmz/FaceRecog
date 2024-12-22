const Students = require('../Models/StudentSchema');
const bcrypt = require('bcrypt');
const LoginUser = async (email, password) => {
    try {
        const user = await Students.findOne({ email: email });
        const passwodValidation = await bcrypt.compare(password, user.password);
        if (!user) {
            return null;
        }

        if (!passwodValidation) {
            console.log('Invalid password');
            return 'Invalid password';
        }

    } catch (e) {
        console.log(e.message);
        
    }
}

module.exports = {LoginUser}
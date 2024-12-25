const Students = require('../Models/StudentSchema');
const bcrypt = require('bcrypt');
const { generatePayloadKeys } = require('../utils/generatePayloadKeys');
const Token = require('../Models/TokenSchemas');
const LoginUser = async (email, password) => {
    try {
        const user = await Students.findOne({ email: email });
        const uid = await user.studentID;
        const hashIt = await bcrypt.hash(uid, 10);
        console.log('Query Result:', user);
        if (!user) {
            console.log('404: User not found');
            return null; 
        }

        const passwordValidation = await bcrypt.compare(password, user.password);
        if (!passwordValidation) {
            console.log('Invalid password');
            return 'Invalid password';
        }

        const token = await generatePayloadKeys(user);
        const users = await user;
        const newToken = new Token({
            token: token,
            studentID: hashIt
        });
        const savedTokelog = await newToken.save();
        return { token, savedTokelog, users };
    } catch (e) {
        console.error('Error in LoginUser:', e.message);
        return null;
    }
};


const LogoutUser = async (studentID) => {
    try {
        return 'User logged out';
    } catch (e) {
        console.error('Error in LogoutUser:', e.message);
        return null;
    }
};


module.exports = {LoginUser}
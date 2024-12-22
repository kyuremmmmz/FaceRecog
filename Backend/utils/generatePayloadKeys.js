const jwebtoken = require('jsonwebtoken');
const { generateSecretKey } = require('../config/jwt');

const generatePayloadKeys = (user) => {
    const payload = {
        id: user._id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        studentID: user.studentID,
        block: user.block,
        password: user.password,
        iat: new Date().getTime(),
    }
    return jwebtoken.sign(payload, generateSecretKey, {
        expiresIn: '1h'
    });
}

module.exports = {generatePayloadKeys};
const crypto = require('crypto');


const generateToken = () => {
    const token = crypto.randomBytes(32).toString('hex');
    return token;
}


module.exports = {generateToken};
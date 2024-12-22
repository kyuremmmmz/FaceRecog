const crypto = require('crypto');
const generateSecretKey = crypto.randomBytes(32).toString('hex');

module.exports = { generateSecretKey: generateSecretKey };
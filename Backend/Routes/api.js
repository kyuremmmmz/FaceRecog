const router = require('express');
const Router = router.Router();
const userController = require('../Controller/Auth/Registration')
Router.post('/auth/register', userController.register)

module.exports = Router;







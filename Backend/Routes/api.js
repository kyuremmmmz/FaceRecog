const router = require('express');
const Router = router.Router();
const userController = require('../Controller/Auth/Registration')
const imagepath = require('../Controller/Auth/getStudent')
Router.post('/auth/register', userController.register)
Router.post('/auth/login', userController.login);
Router.post('/getstudent', imagepath.getImage);
module.exports = Router;







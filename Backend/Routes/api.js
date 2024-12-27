const router = require('express');
const Router = router.Router();
const userController = require('../Controller/Auth/Registration')
const imagepath = require('../Controller/Auth/getStudent')
const attendance = require('../Controller/Main/AttendanceController')
Router.post('/auth/register', userController.register)
Router.post('/auth/login', userController.login);
Router.post('/getstudent', imagepath.getImage);
Router.post('/attend', attendance.AttendanceController);
module.exports = Router;







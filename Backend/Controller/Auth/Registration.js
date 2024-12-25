const { LoginUser } = require("../../Services/LoginService");
const { Register } = require("../../Services/SignUpService");



exports.register = async (req, res, next) => {
    try {
        const userData = await req.body;
        console.log(userData);

        const registerService = await Register(userData);
        res.status(201).json({
            message: "User registered successfully",
            user: registerService
        });
    } catch (err) {
        console.error('Error:', err.message);
        res.status(500).json({
            message: "An error occurred while registering the user",
            error: err.message
        });
        next(err);
    }
};

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const userData = await LoginUser(email, password);
        if (!userData) {
            return res.status(401).json({
                message: "Invalid email or password"
            });
        }
        
        res.status(200).json({
            message: "User logged in successfully",
            user: userData,
            email: req.body.email,
            data: userData.users,
        });
    } catch (e) {
        console.error('Error:', e.message);
        res.status(500).json({
            message: "An error occurred while logging in the user",
            error: e.message
        });
        next(e);
    }
}



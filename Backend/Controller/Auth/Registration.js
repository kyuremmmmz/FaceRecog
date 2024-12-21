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


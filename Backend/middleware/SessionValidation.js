const Session = (req, res, next) => { 
    if (!req.session || !req.session.token) {
        return res.status(401).json({
            message: "Unauthorized"
        });
    }
    next();
}
 
module.exports = {Session}
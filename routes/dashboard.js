const express = require("express");
const router = express.Router();
const dashboardController = require("../controllers/dashboard");
const passport = require("../config/passport");

router.get("/", passport.authenticateJWT, dashboardController.all);

module.exports = router;

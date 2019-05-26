const express = require("express");
const authController = require("../../controllers/auth");
const passport = require("../../config/passport");

const router = express.Router();

router.post("/signup", authController.signUp);
router.post("/signin", authController.signIn);
router.get("/", passport.authenticateJWT, authController.getUser);
module.exports = router;

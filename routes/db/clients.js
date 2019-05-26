const express = require("express");
const router = express.Router();
const clients = require("../../controllers/clients");
const passport = require("../../config/passport");

router.get("/", passport.authenticateJWT, clients.all);

module.exports = router;

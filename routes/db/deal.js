const express = require("express");
const router = express.Router();
const dealController = require("../../controllers/deals");
const passport = require("../../config/passport");

router.post("/", passport.authenticateJWT, dealController.create);
router.delete("/:dealid", passport.authenticateJWT, dealController.remove);
router.put("/move/:dealid", passport.authenticateJWT, dealController.move);
router.put(
  "/:dealid/:clientid",
  passport.authenticateJWT,
  dealController.update
);

module.exports = router;

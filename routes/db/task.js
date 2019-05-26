const express = require("express");
const router = express.Router();
const taskController = require("../../controllers/tasks");
const passport = require("../../config/passport");

router.post("/:dealid", passport.authenticateJWT, taskController.create);
router.delete("/:taskid", passport.authenticateJWT, taskController.remove);
router.put("/:taskid", passport.authenticateJWT, taskController.update);
router.get("/:dealid", passport.authenticateJWT, taskController.all);

module.exports = router;

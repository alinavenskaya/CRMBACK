const express = require("express");
const router = express.Router();
const dbController = require("../../controllers/db");

// router.get("/:userid", (req, res) => dbController.getAll(req, res, "deals"));
router.get("/:userid", dbController.getBoard);
router.post("/", (req, res) => dbController.create(req, res, "deals"));

module.exports = router;

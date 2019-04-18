const express = require('express')
const router = express.Router()
const dbController = require('../../controllers/db')

router.get('/:dealid', (req, res) => dbController.getAll(req, res, 'tasks'))

module.exports = router

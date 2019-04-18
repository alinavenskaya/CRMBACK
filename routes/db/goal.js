const express = require('express')
const router = express.Router()
const dbController = require('../../controllers/db')

router.post('/', (req, res) => dbController.create(req, res, 'goals'))
router.delete('/:goalid', (req, res) => dbController.remove(req, res, 'goals'))
router.put('/', (req, res) => dbController.update(req, res, 'goals'))

module.exports = router
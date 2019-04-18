const express = require('express')
const router = express.Router()
const dbController = require('../../controllers/db')

router.post('/', (req, res) => dbController.create(req, res, 'deals'))
router.delete('/:dealid', (req, res) => dbController.remove(req, res, 'deals'))
router.put('/', (req, res) => dbController.update(req, res, 'deals'))

module.exports = router
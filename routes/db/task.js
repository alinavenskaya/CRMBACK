const express = require('express')
const router = express.Router()
const dbController = require('../../controllers/db')

router.post('/', (req, res) => dbController.create(req, res, 'tasks'))
router.delete('/:taskid', (req, res) => dbController.remove(req, res, 'tasks'))
router.put('/', (req, res) => dbController.update(req, res, 'tasks'))

module.exports = router
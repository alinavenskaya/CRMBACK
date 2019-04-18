const express = require('express')
const router = express.Router()
const dbController = require('../../controllers/db')

router.post('/', (req, res) => dbController.create(req, res, 'clients'))
router.delete('/:clientid', (req, res) =>
  dbController.remove(req, res, 'clients')
)
router.put('/', (req, res) => dbController.update(req, res, 'clients'))

module.exports = router
const router = require('express').Router()
// const goalsRouter = require('./goals')
// const tasksRouter = require('./tasks')
// const clientsRouter = require('./clients')
// const dealsRouter = require('./deals')
// const goalRouter = require('./goal')
// const taskRouter = require('./task')
// const clientRouter = require('./client')
// const dealRouter = require('./deal')
const dbController = require('../../controllers/db')
router.get('/actions', dbController.selectActions)

// const authRouter = require('./auth');
// const userRouter = require('./user');

// router.use('/clients', clientsRouter)
// router.use('/deals', dealsRouter)
// router.use('/tasks', tasksRouter)
// router.use('/goals', goalsRouter)

// router.use('/client', clientRouter)
// router.use('/deal', dealRouter)
// router.use('/task', taskRouter)
// router.use('/goal', goalRouter)

module.exports = router

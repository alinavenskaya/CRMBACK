const router = require("express").Router();
const dbRouter = require("./db");
const tasksRouter = require("./db/tasks");
const clientsRouter = require("./db/clients");
const dealsRouter = require("./db/deals");
const goalRouter = require("./db/goal");
const taskRouter = require("./db/task");
const clientRouter = require("./db/client");
const dealRouter = require("./db/deal");
const authRouter = require("./auth");
const dashboardRouter = require("./dashboard");

router.use("/clients", clientsRouter);
router.use("/deals", dealsRouter);
router.use("/tasks", tasksRouter);
router.use("/client", clientRouter);
router.use("/deal", dealRouter);
router.use("/task", taskRouter);
router.use("/goal", goalRouter);
router.use("/db", dbRouter);
router.use("/users", authRouter);
router.use("/dashboard", dashboardRouter);

module.exports = router;

const db = require("knex")({
  client: "pg",
  connection: process.env.POSTGRES_URI
});

const all = async (req, res) => {
  const { userid } = req.user;
  const { dealid } = req.params;
  try {
    const tasks = await db
      .select([
        "taskid as id",
        "taskname as name",
        "taskdate as date",
        "taskstatus as status"
      ])
      .from("tasks")
      .where({ dealid, userid })
      .orderBy("taskid");
    return res.status(200).json(tasks);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};

const create = async (req, res) => {
  const { userid } = req.user;
  const { dealid } = req.params;
  const { name: taskname, date: taskdate } = req.body;
  try {
    const [task] = await db("tasks")
      .insert({
        userid,
        dealid,
        taskname,
        taskdate,
        taskstatus: false
      })
      .returning([
        "taskid as id",
        "taskname as name",
        "taskdate as date",
        "taskstatus as status"
      ]);
    return res.status(200).json(task);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};

const update = async (req, res) => {
  const { taskid } = req.params;
  const { name: taskname, date: taskdate, status: taskstatus } = req.body;
  try {
    const [task] = await db("tasks")
      .update({
        taskname,
        taskdate,
        taskstatus
      })
      .where({ taskid })
      .returning([
        "taskid as id",
        "taskname as name",
        "taskdate as date",
        "taskstatus as status"
      ]);
    return res.status(200).json(task);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};
const remove = async (req, res) => {
  const { taskid } = req.params;
  try {
    await db("tasks")
      .where({ taskid })
      .del();
    return res.status(204);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};

module.exports = {
  all,
  create,
  update,
  remove
};

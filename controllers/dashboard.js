const db = require("knex")({
  client: "pg",
  connection: process.env.POSTGRES_URI
});

const all = async (req, res) => {
  const { userid } = req.user;
  try {
    let statistics = await db.raw(`SELECT dashboard(${Number(userid)})`);
    const dashboard = statistics.rows[0].dashboard;
    const emptyList = {
      sumprice: 0,
      countdeals: 0
    };
    if (dashboard.firstContact === null) {
      dashboard.firstContact = emptyList;
    }
    if (dashboard.meeting === null) {
      dashboard.meeting = emptyList;
    }
    if (dashboard.sentoffer === null) {
      dashboard.sentoffer = emptyList;
    }
    if (dashboard.sentcontract === null) {
      dashboard.sentcontract = emptyList;
    }
    if (dashboard.inprocess === null) {
      dashboard.inprocess = emptyList;
    }
    if (dashboard.sucess === null) {
      dashboard.sucess = emptyList;
    }
    if (dashboard.overdue === null) {
      dashboard.overdue = 0;
    }
    if (dashboard.todo === null) {
      dashboard.todo = 0;
    }
    if (dashboard.done === null) {
      dashboard.done = 0;
    }
    if (dashboard.missingtasks === null) {
      dashboard.missingtasks = 0;
    }

    return res.status(200).json(dashboard);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};

module.exports = {
  all
};

const db = require("knex")({
  client: "pg",
  connection: process.env.POSTGRES_URI
});

const all = async (req, res) => {
  const { userid } = req.user;
  try {
    const [user] = await db
      .select("userscompaniesid")
      .from("users")
      .where({ userid });
    const [goal] = await db
      .select("goalvalue as goal")
      .from("goals")
      .where({ userscompaniesid: user.userscompaniesid });
    return res.status(200).json(goal);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};

const update = async (req, res) => {
  const { goal: goalvalue } = req.body;
  try {
    const goal = await db("goals")
      .update({ goalvalue })
      .where({ goalid: 1 });
    return res.status(200).json({ goal: goal.goalvalue });
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};

module.exports = {
  all,
  update
};

const db = require("knex")({
  client: "pg",
  connection: process.env.POSTGRES_URI
});

const getAll = async (req, res, table) => {
  const { userid } = req.user;
  try {
    const data = await db
      .select("*")
      .from(table)
      .where({ userid });
    return res.status(200).json(data);
  } catch (e) {
    return res.status(400).json(e);
  }
};

const create = async (req, res, table) => {
  const { ...body } = req.body;
  // const [values] = Object.values(body)
  try {
    const data = await db(table)
      .insert(body)
      .returning("*");
    return res.status(200).json(data);
  } catch (e) {
    console.error(e);
    return res.sendStatus(403);
  }
};

const remove = async (req, res, table) => {
  const { ...id } = req.params;
  try {
    await db(table)
      .where(id)
      .del();
    return res.sendStatus(204);
  } catch (e) {
    console.log(e);
    return res.sendStatus(403);
  }
};

const update = async (req, res, table) => {
  const { ...body } = req.body;
  const [obj] = Object.values(body);
  const { id, ...updateValue } = obj;
  try {
    const data = await db(table)
      .where({ [id.name]: id.value })
      .update(fields)
      .returning("*");
    return res.status(200).json(data);
  } catch (e) {
    return res.status(400).json(e);
  }
};

const selectActions = async (req, res) => {
  const { take, skip } = req.query;
  try {
    const items = await db
      .select(["actiontype", "actiondate", "objecttype"])
      .from("actionlog")
      .limit(take)
      .offset(skip);
    // db returns array with object count inside
    let [totalCount] = await db("actionlog").count("actionid");
    totalCount = totalCount.count;
    return res.status(200).json({ items, totalCount });
  } catch (e) {
    return res.status(400).json(e);
  }
};

const getBoard = async (req, res) => {
  try {
    const board = await db.raw("SELECT board()");
    return res.status(200).json(
      board.rows.reduce((acc, item) => {
        acc[item.board.name] =
          item.board.deals[0] === null ? [] : item.board.deals;
        return acc;
      }, {})
    );
  } catch (e) {
    res.sendStatus(403);
  }
};
module.exports = {
  selectActions,
  getAll,
  create,
  remove,
  update,
  getBoard
};

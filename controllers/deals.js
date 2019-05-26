const db = require("knex")({
  client: "pg",
  connection: process.env.POSTGRES_URI
});
const moment = require("moment");

const move = async (req, res) => {
  try {
    const { dealid } = req.params;
    console.log(dealid);
    const { stagename } = req.body;
    const [response] = await db
      .select("stageid")
      .from("stages")
      .where({ stagename });
    await db("deals")
      .where({ dealid })
      .update({ stageid: response.stageid });
    return res.sendStatus(204);
  } catch (e) {
    console.log(e);
    return res.sendStatus(403);
  }
};
const create = async (req, res) => {
  try {
    const {
      dealname,
      dealprice,
      clientname,
      clientcompanyname,
      clientphone,
      clientemail
    } = req.body;
    const { userid } = req.user;

    const [client] = await db("clients")
      .insert({
        userscompaniesid: 1,
        clientname,
        clientcompanyname,
        clientphone,
        clientemail
      })
      .returning([
        "clientid as id",
        "clientcompanyname as company",
        "clientphone as phone",
        "clientemail as email"
      ]);
    const dealdate = moment()
      .utc()
      .format();
    const [manager] = await db
      .select("userid as id", "username as name", "userphoto as avatar")
      .from("users")
      .where({ userid });
    const [deal] = await db("deals")
      .insert({
        userid,
        dealname,
        dealprice,
        clientid: client.id,
        stageid: 1, //default stage
        dealdate
      })
      .returning(["dealid as id", "dealname as name", "dealprice as price"]);
    return res.status(200).json({ ...deal, client, manager });
  } catch (e) {
    console.log(e);
    return res.sendStatus(403);
  }
};

const remove = async (req, res) => {
  const { dealid } = req.params;
  try {
    await db("tasks")
      .where({ dealid })
      .del();
    await db("deals")
      .where({ dealid })
      .del();
    res.sendStatus(204);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};
const update = async (req, res) => {
  try {
    const { dealid, clientid } = req.params;
    const { userid } = req.user;
    const [manager] = await db
      .select("userid as id", "username as name", "userphoto as avatar")
      .from("users")
      .where({ userid });
    const {
      clientname,
      clientemail,
      clientphone,
      clientcompanyname,
      dealprice,
      dealname
    } = req.body;
    const [client] = await db("clients")
      .update({
        clientname,
        clientemail,
        clientphone,
        clientcompanyname
      })
      .where({ clientid })
      .returning([
        "clientid as id",
        "clientcompanyname as company",
        "clientphone as phone",
        "clientemail as email"
      ]);
    const [deal] = await db("deals")
      .update({ dealprice, dealname })
      .where({ dealid })
      .returning(["dealid as id", "dealname as name", "dealprice as price"]);
    return res.status(200).json({ ...deal, client, manager });
  } catch (e) {
    console.log(e);
    return res.sendStatus(403);
  }
};

module.exports = {
  move,
  create,
  remove,
  update
};

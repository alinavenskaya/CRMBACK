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
    const clients = await db
      .select([
        "clientname as name",
        "clientcompanyname as company",
        "clientphone as phone",
        "clientemail as email"
      ])
      .from("clients")
      .where({ userscompaniesid: user.userscompaniesid });
    return res.status(200).json(clients);
  } catch (e) {
    console.log(e);
    res.sendStatus(403);
  }
};

module.exports = {
  all
};

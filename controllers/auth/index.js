const jwt = require("jsonwebtoken");
// const bcrypt = require("bcrypt-nodejs");
const crypto = require("crypto");
const db = require("knex")({
  client: "pg",
  connection: process.env.POSTGRES_URI
});
const config = require("../../config/db");
const PassportManager = require("../../config/passport");

const signUp = async (req, res) => {
  const { username, password: userpassword, email: useremail } = req.body.user;
  if (!username || !userpassword || !useremail) {
    res.status(422).json({
      success: false,
      msg: "Пожалуйтса введите имя пользователя и пароль"
    });
  } else {
    const salt = crypto.randomBytes(16).toString("hex");
    const hash = crypto
      .pbkdf2Sync(userpassword, salt, 10000, 512, "sha512")
      .toString("hex");

    const [userData] = await db("users")
      .insert({ username, userpassword: hash, useremail, salt })
      .returning(["userid", "username", "usertype"]);

    const token = jwt.sign(userData, config.secret, {
      expiresIn: "30d"
    });
    return res.json({
      user: { ...userData, token },
      success: true
    });
  }
};

const signIn = (req, res, next) => {
  PassportManager.authenticateLocal(req, res, next);
};

const getUser = (req, res) => {
  const user = req.user;
  res.status(200).json({ user });
};
module.exports = {
  signUp,
  signIn,
  getUser
};

const passport = require("passport");
const { Strategy, ExtractJwt } = require("passport-jwt");
const LocalStrategy = require("passport-local").Strategy;
const jwt = require("jsonwebtoken");
const crypto = require("crypto");
// const bcrypt = require("bcrypt-nodejs");
const db = require("knex")({
  client: "pg",
  connection: process.env.POSTGRES_URI
});
const config = require("./db");
// get db config file
const initialize = () => {
  const opts = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderWithScheme("Token"),
    secretOrKey: config.secret
  };
  passport.use(
    new Strategy(opts, async (jwtPayload, done) => {
      const [user] = await db
        .select("*")
        .from("users")
        .where({ userid: jwtPayload.userid });
      if (user) {
        return done(null, user);
      } else {
        return done(null, false);
      }
    })
  );

  passport.use(
    new LocalStrategy(
      {
        usernameField: "user[email]",
        passwordField: "user[password]"
      },
      async (useremail, password, done) => {
        console.log("why am i here?");
        const [user] = await db
          .select(
            "useremail",
            "usertype",
            "userpassword",
            "salt",
            "username",
            "userid",
            "userfullname",
            "userphoto"
          )
          .from("users")
          .where({ useremail });
        if (!user) {
          return done(null, false, {
            errors: { "email or password": "is invalid" }
          });
        } else {
          // check if password matches
          const hash = crypto
            .pbkdf2Sync(password, user.salt, 10000, 512, "sha512")
            .toString("hex");
          if (user.userpassword === hash) {
            const { userpassword, salt, ...returningUser } = user;
            return done(null, returningUser);
          }
          return done(null, false, {
            errors: { "email or password": "is invalid" }
          });
        }
      }
    )
  );
  return passport.initialize();
};

const authenticateJWT = (req, res, next) => {
  passport.authenticate("jwt", (err, user, info) => {
    if (err) {
      return next(err);
    }
    if (!user) {
      if (info.name === "TokenExpiredError") {
        return res.status(401).json({ message: "Your token has expired." });
      }
      return res.status(401).json({ message: info.message });
    }
    req.user = user;
    return next();
  })(req, res, next);
};

const authenticateLocal = (req, res, next) => {
  passport.authenticate("local", (err, user, info) => {
    if (err) {
      return next(err);
    }
    if (user) {
      // if user is found and password is right create a token
      const token = jwt.sign(user, config.secret, {
        expiresIn: "30d"
      });
      // return the information including token as JSON
      return res.json({ user: { ...user, token: `${token}` }, success: true });
    } else {
      return res.status(422).json(info);
    }
  })(req, res, next);
};

module.exports = {
  initialize,
  authenticateJWT,
  authenticateLocal
};

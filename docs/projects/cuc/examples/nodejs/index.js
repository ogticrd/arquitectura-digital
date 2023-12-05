const { Strategy } = require("passport-oauth2");
const passport = require("passport");
const express = require("express");
const crypto = require("crypto");

const PORT = process.env.PORT || 3000;

passport.use(
  new Strategy(
    {
      authorizationURL: `${process.env.OAUTH_URL}/oauth2/auth`,
      tokenURL: `${process.env.OAUTH_URL}/oauth2/token`,
      clientID: process.env.OAUTH_CLIENT_ID,
      clientSecret: process.env.OAUTH_CLIENT_SECRET,
      callbackURL: "http://localhost:3000/callback",
      state: crypto.randomBytes(20).toString("hex"),
      scope: ["openid", "email", "offline_access"],
    },
    (accessToken, refreshToken, profile, cb) => {
      console.log({
        accessToken,
        refreshToken,
        profile,
      });

      return cb(null, profile);
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((obj, done) => {
  done(null, obj);
});

const app = express();

app.use(
  require("express-session")({
    secret: "tu-secreto",
    resave: true,
    saveUninitialized: true,
  })
);
app.use(passport.initialize());
app.use(passport.session());

app.get("/", (req, res) => {
  res.send(
    '¡Hola! <a href="/auth/cuentaunica">Iniciar sesión con Cuenta única</a>'
  );
});

app.get("/auth/cuentaunica", passport.authenticate("oauth2"));

app.get(
  "/callback",
  passport.authenticate("oauth2", { failureRedirect: "/" }),
  (req, res) => {
    res.redirect("/profile");
  }
);

app.get("/profile", (req, res) => {
  // Verifica si el usuario ha iniciado sesión
  if (req.isAuthenticated()) {
    // Devuelve la información del usuario
    res.json(req.user);
  } else {
    res.redirect("/");
  }
});

app.listen(PORT, () =>
  console.log(`App is up an running on http://localhost:${PORT}`)
);

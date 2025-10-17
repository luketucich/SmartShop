const express = require(`express`);
const models = require(`./models`);
const { Op } = require("sequelize");
const bcrypt = require("bcryptjs");
const { body, validationResult } = require("express-validator");
const app = express();

// JSON middleware
app.use(express.json());

// Registration validation middleware
const registerValidator = [
  body("username", "Username cannot be empty").not().isEmpty(),
  body("password", "Password cannot be empty").not().isEmpty(),
];

app.post("/register", registerValidator, async (req, res) => {
  // Check if username or password is empty
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const msg = errors
      .array()
      .map((err) => err.msg)
      .join(", ");
    return res.status(422).json({ success: false, message: msg });
  }

  try {
    // Check if user already exists
    const { username, password } = req.body;
    const existingUser = await models.User.findOne({
      where: {
        username: { [Op.iLike]: username },
      },
    });

    if (existingUser) {
      return res
        .status(409)
        .json({ success: false, message: "Username already exists" });
    }
    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create a new user in the database
    const _ = models.User.create({
      username: username,
      password: hashedPassword,
    });

    res
      .status(201)
      .json({ success: true, message: "User registered successfully" });
  } catch (error) {
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

app.listen(8080, () => {
  console.log(`Server is running on http://localhost:8080`);
});

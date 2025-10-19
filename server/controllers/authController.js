const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const { validationResult } = require("express-validator");
const { Op } = require("sequelize");
const models = require("../models");
const user = require("../models/user");

exports.login = async (req, res) => {
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
    // Check if user exists
    const { username, password } = req.body;
    const existingUser = await models.User.findOne({
      where: {
        username: { [Op.iLike]: username },
      },
    });

    if (!existingUser) {
      return res
        .status(401)
        .json({ success: false, message: "Invalid username or password" });
    }

    // If user exists, compare passwords
    const isPasswordValid = await bcrypt.compare(
      password,
      existingUser.password
    );
    if (!isPasswordValid) {
      return res
        .status(401)
        .json({ success: false, message: "Invalid username or password" });
    }

    // If valid credentials, generate JWT token
    const token = jwt.sign(
      {
        userId: existingUser.id,
        username: existingUser.username,
      },
      "SECRETKEY",
      {
        expiresIn: "1h",
      }
    );

    return res.status(200).json({
      success: true,
      message: "Login successful",
      userId: existingUser.id,
      username: existingUser.username,
      token,
    });
  } catch (error) {
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};

exports.register = async (req, res) => {
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
};

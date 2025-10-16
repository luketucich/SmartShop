const express = require(`express`);
const models = require(`./models`);
const app = express();

// JSON middleware
app.use(express.json());

app.post("/register", (req, res) => {
  const { username, password } = req.body;

  // Create a new user in the database
  const newUser = models.User.create({
    username: username,
    password: password,
  });

  res.status(201).json({ message: "User registered successfully" });
});

app.listen(8080, () => {
  console.log(`Server is running on http://localhost:8080`);
});

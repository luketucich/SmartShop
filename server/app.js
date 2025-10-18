const express = require(`express`);
const cors = require("cors");
const authRoutes = require("./routes/auth");
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Register routes
app.use("/api/auth", authRoutes);

// Start the server
app.listen(8080, () => {
  console.log(`Server is running on http://localhost:8080`);
});

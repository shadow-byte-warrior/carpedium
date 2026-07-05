const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const path = require("path");
require("dotenv").config();

const Enquiry = require("./enquiry.model");

const app = express();
const PORT = process.env.PORT || 5000;
const MONGODB_URI = process.env.MONGODB_URI || "mongodb://127.0.0.1:27017/carpediem";

// Middleware
app.use(cors());
app.use(express.json());

// MongoDB connection
mongoose
  .connect(MONGODB_URI, {
    serverSelectionTimeoutMS: 2000, // Fail fast in 2s if local DB is offline
  })
  .then(() => console.log("Successfully connected to MongoDB database."))
  .catch((err) => {
    console.log("\n========================================================");
    console.log("[STATUS] Local MongoDB database is offline/not started.");
    console.log("[STATUS] MERN server is running in offline simulation mode.");
    console.log("[STATUS] Enquiries will be logged directly to this console.");
    console.log("========================================================\n");
  });

// API endpoint to log enquiries
app.post("/api/enquiry", async (req, res) => {
  try {
    const { name, email, phone, course, college, message } = req.body;

    // Simple Server-side validation
    if (!name || !email || !phone || !course || !college) {
      return res.status(400).json({ error: "Missing required form fields" });
    }

    const mockData = {
      name,
      email,
      phone,
      course,
      college,
      message,
      _id: new mongoose.Types.ObjectId(),
      createdAt: new Date(),
    };

    // Check if database is connected (readyState === 1 means connected)
    if (mongoose.connection.readyState !== 1) {
      console.log("\n========================================================");
      console.log("[WARNING] MongoDB is not running or disconnected!");
      console.log("Saving enquiry in simulation mode (logged to console):");
      console.log(JSON.stringify(mockData, null, 2));
      console.log("========================================================\n");

      return res.status(201).json({
        success: true,
        message: "Enquiry logged successfully (Console Simulation Mode)",
        data: mockData,
      });
    }

    const newEnquiry = new Enquiry({
      name,
      email,
      phone,
      course,
      college,
      message,
    });

    const saved = await newEnquiry.save();
    console.log("Admissions enquiry saved to MongoDB:", saved);

    res.status(201).json({ success: true, message: "Enquiry logged successfully", data: saved });
  } catch (error) {
    console.error("Error saving enquiry:", error);
    res.status(500).json({ error: "Internal server error occurred while saving enquiry" });
  }
});

// Serve frontend static build files in production
app.use(express.static(path.join(__dirname, "dist")));

// Client-side fallback routing
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "dist", "index.html"));
});

app.listen(PORT, () => {
  console.log(`Server is running in production mode on port ${PORT}`);
});

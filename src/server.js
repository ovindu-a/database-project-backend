const express = require('express');
const app = express();
const dotenv = require('dotenv');

console.log("Starting server setup...");

// Load environment variables
dotenv.config();
console.log("Environment variables loaded");

// Middleware
app.use(express.json());
console.log("Middleware setup complete");

// Import routes
const accountRoutes = require('./routes/accountRoutes');
const branchRoutes = require('./routes/branchRoutes');
const managerRoutes = require('./routes/managerRoutes');

console.log("Routes imported");

// Use routes
app.use('/api/accounts', accountRoutes);
app.use('/api/branches', branchRoutes);
app.use('/api/managers', managerRoutes);

console.log("Routes setup complete");

// Start Server
const start = () => {
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });
  };

module.exports = { start };
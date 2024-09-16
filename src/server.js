const express = require('express');
const app = express();
const dotenv = require('dotenv');

const cors = require('cors');

// Use CORS middleware
app.use(cors({
  origin: 'http://localhost:3000', // Your frontend URL
  credentials: true // Allow credentials (cookies)
}));

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
const customerRoutes = require('./routes/customerRoutes');
const employeeRoutes = require('./routes/employeeRoutes');
const FDRoutes = require('./routes/FDRoutes');
const loanRoutes = require('./routes/loanRoutes');
const transactionRoutes = require('./routes/transactionRoutes');
const loanApplicationRoutes = require('./routes/loanApplicationRoutes');
const loanInstallmentRoutes = require('./routes/loanInstallmentRoutes');
const analysisRoutes = require('./routes/analysisRoutes');

console.log("Routes imported");

// Use routes
app.use('/api/accounts', accountRoutes);
app.use('/api/branches', branchRoutes);
app.use('/api/managers', managerRoutes);
app.use('/api/customers', customerRoutes);
app.use('/api/employees', employeeRoutes);
app.use('/api/fixedDeposits', FDRoutes);
app.use('/api/loans', loanRoutes);
app.use('/api/transactions', transactionRoutes);
app.use('/api/loanApplications', loanApplicationRoutes);
app.use('/api/loanInstallments', loanInstallmentRoutes);
app.use('/api/analysis', analysisRoutes);

   

console.log("Routes setup complete");

// Start Server
const start = () => {
    const PORT = process.env.PORT || 3001;
    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });
  };

module.exports = { start };
const Customer = require('../models/customerModel');
const Loan = require('../models/loanModel');
const FixedDeposit = require('../models/FDModel');
const Account = require('../models/accountModel');
const bcrypt = require('bcryptjs');
const { createJwtToken } = require('../middleware/authMiddleware'); // Update this line
const { sendOtp, generateOtp } = require('../services/otpService'); // Update this line

let otpStorage = {};

exports.getAllCustomers = async (req, res) => {
  try {
    const customers = await Customer.getAll();
    res.json(customers);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createCustomer = async (req, res) => {
  const { Name, NIC, Address, username, password } = req.body;

  try {
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const customerId = await Customer.create(Name, NIC, Address, username, hashedPassword);
    res.status(201).json({ Customer_ID: customerId, Name, username });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getCustomerById = async (req, res) => {
  const { id } = req.params;
  try {
    const customer = await Customer.getById(id);
    if (customer) {
      res.json(customer);
    } else {
      res.status(404).json({ message: 'Customer not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateCustomer = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  try {
    const affectedRows = await Customer.update(id, updates);
    if (affectedRows) {
      res.json({ message: 'Customer updated successfully' });
    } else {
      res.status(404).json({ message: 'Customer not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteCustomer = async (req, res) => {
  const { id } = req.params;
  try {
    const affectedRows = await Customer.delete(id);
    if (affectedRows) {
      res.json({ message: 'Customer deleted successfully' });
    } else {
      res.status(404).json({ message: 'Customer not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.loginCustomer = async (req, res) => {
  const { username, password } = req.body;
  console.log(username);

  try {
    const customer = await Customer.getByUsername(username);

    if (!customer) {
      return res.status(404).json({ message: 'Customer not found' });
    }

    const isPasswordValid = await bcrypt.compare(password, customer.Password);

    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }

    // Generate OTP
    const otp = generateOtp(); // Use the new service to generate OTP
    otpStorage[customer.Customer_ID] = otp; // Store OTP temporarily

    // Send OTP via email
    sendOtp(customer.Email, otp); // Use the service to send OTP

    // Send response indicating successful password validation and OTP sent
    res.status(200).json({ message: 'OTP sent to your email', Customer_ID: customer.Customer_ID });

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// // Protect API routes with verifyCookie middleware
// exports.getAllCustomers = verifyCookie; // Use the imported middleware
// exports.getCustomerById = verifyCookie; // Use the imported middleware
// exports.updateCustomer = verifyCookie; // Use the imported middleware
// exports.deleteCustomer = verifyCookie; // Use the imported middleware

exports.verifyOtp = (req, res) => {
  const { Customer_ID, otp } = req.body;
  // console.log(req.body)
  // console.log(otpStorage, otp, Customer_ID)
  // console.log(otpStorage[Customer_ID] == otp)
  // Check if the OTP exists and matches
  if (otpStorage[Customer_ID] && otpStorage[Customer_ID] === otp) {
    delete otpStorage[Customer_ID]; // Clear OTP after verification

    // Generate JWT token

    const token = createJwtToken(req, res, Customer_ID);

    // Set token in cookie
    res.cookie('token', token, { httpOnly: true, secure: false, maxAge:200000000 }); // Set secure to true in production

    return res.status(200).json({ message: 'OTP verified successfully, you are logged in.', Customer_ID: Customer_ID});
  } else {
    return res.status(401).json({ message: 'Invalid OTP' });
  }
};
 
exports.getCustomerByLoanId = async (req, res) => {
  const { id } = req.params;
  try {
    const customer = await Customer.getByLoanId(id);
    if (!customer) {
      return res.status(404).json({ message: 'Customer not found' });
    }

    const loan = await Loan.getById(id);
    if (!loan) {
      return res.status(404).json({ message: 'Loan not found' });
    }

    const combinedData = {
      ...customer,
      loan
    };

    return res.json(combinedData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

exports.getBriefInfoByCustomerId = async (req, res) => {
  const { id } = req.params;
  console.log('Ready to give brief info for customer:', id);
  try {
    const user = await Customer.getById_opt(id);
    const accounts = await Account.getByCustomer_opt(id);
    const loans = await Loan.getByCustomer_opt(id);
    const fds = await FixedDeposit.getFDsByCustomerId(id);

    // Reconstruct
    const combinedData = {
      user,
      accounts,
      loans,
      fds: fds.map(fd => ({
        FD_ID: fd.FD_ID,
        Amount: fd.InitialAmount,
      }))
    };
    res.json(combinedData); 
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

const Customer = require('../models/customerModel');
const bcrypt = require('bcryptjs');
const { verifyCookie } = require('../middleware/authMiddleware'); // Update this line
const jwt = require('jsonwebtoken'); // Keep this line
const JWT_SECRET = 'yourSecretKey'; // Keep this line
const nodemailer = require('nodemailer'); // Add this line
const { sendOtp, generateOtp } = require('../services/otpService'); // Update this line

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

    // Send OTP via email
    await sendOtp(customer.Email, otp); // Use the new service to send OTP

    // Generate JWT token
    const token = jwt.sign({ Customer_ID: customer.Customer_ID }, JWT_SECRET, { expiresIn: '1h' });

    // Set token in cookie
    res.cookie('token', token, { httpOnly: true, secure: false }); // Set secure to true in production
    res.status(200).json({ message: 'Login successful, OTP sent to your email', Customer_ID: customer.Customer_ID, otp }); // Include OTP in response for testing
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// // Protect API routes with verifyCookie middleware
// exports.getAllCustomers = verifyCookie; // Use the imported middleware
// exports.getCustomerById = verifyCookie; // Use the imported middleware
// exports.updateCustomer = verifyCookie; // Use the imported middleware
// exports.deleteCustomer = verifyCookie; // Use the imported middleware

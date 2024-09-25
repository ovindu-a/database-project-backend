const Employee = require('../models/employeeModel');
const bcrypt = require('bcryptjs');
const { sendOtp, generateOtp } = require('../services/otpService'); // Import OTP service
const { createJwtToken } = require('../middleware/authMiddleware'); // Import JWT creation function
let otpStorage = {}; // Temporary storage for OTPs

exports.getAllEmployees = async (req, res) => {
  try {
    const employees = await Employee.getAll();
    res.json(employees);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createEmployee = async (req, res) => {
  const { Branch_ID, name, username, password } = req.body;
  try {
    const saltRounds = 10; // You can adjust the salt rounds
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const employeeId = await Employee.create(Branch_ID, name, username, hashedPassword);
    res.status(201).json({ Employee_ID: employeeId, name, username });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getEmployeeById = async (req, res) => {
  const { id } = req.params;
  console.log("Requesting employee with id: ", id);
  try {
    const employee = await Employee.getById(id);
    if (employee) {
      res.json(employee);
    } else {
      res.status(404).json({ message: 'Employee not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateEmployee = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  
  try {
    const affectedRows = await Employee.update(id, updates);
    if (affectedRows) {
      res.json({ message: 'Employee updated successfully' });
    } else {
      res.status(404).json({ message: 'Employee not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteEmployee = async (req, res) => {
  const { id } = req.params;
  try {
    const affectedRows = await Employee.delete(id);
    if (affectedRows) {
      res.json({ message: 'Employee deleted successfully' });
    } else {
      res.status(404).json({ message: 'Employee not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.loginEmployee = async (req, res) => {
  const { username, password } = req.body;
  try {
    const employee = await Employee.getByUsername(username);
    
    if (!employee) {
      return res.status(404).json({ message: 'Employee not found' });
    }

    const isPasswordValid = await bcrypt.compare(password, employee.Password);
    
    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }

    // Generate OTP
    const otp = generateOtp();
    otpStorage[employee.Employee_ID] = otp; // Store OTP temporarily
    sendOtp(employee.Email, otp); // Send OTP to employee's email

    // Send response indicating successful password validation and OTP sent
    res.status(200).json({ message: 'Login successful, OTP sent to your email', Employee_ID: employee.Employee_ID });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.verifyOtp = (req, res) => {
  const { Employee_ID, otp } = req.body;

  // Check if the OTP exists and matches
  if (otpStorage[Employee_ID] && otpStorage[Employee_ID] === otp) {
    delete otpStorage[Employee_ID]; // Clear OTP after verification

    // Generate JWT token
    const token = createJwtToken( req, res, Employee_ID ); // Create a token with the employee's ID

    // Set token in cookie
    res.cookie('token', token, { httpOnly: true, secure: false, maxAge: 3600000 }); // Set secure to true in production

    return res.status(200).json({ message: 'OTP verified successfully, you are logged in.' , Employee_ID: Employee_ID });
  } else {
    return res.status(401).json({ message: 'Invalid OTP' });
  }
};

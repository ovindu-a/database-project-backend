const Manager = require('../models/managerModel');
const bcrypt = require('bcryptjs');

exports.getAllManagers = async (req, res) => {
  try {
    const managers = await Manager.getAll();
    res.json(managers);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createManager = async (req, res) => {
  const { name, username, password } = req.body;
  // console.log(req.body);
  try {
    // Hash and salt the password
    const saltRounds = 10; // You can adjust the salt rounds
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const managerId = await Manager.create(name, username, hashedPassword);
    res.status(201).json({ Manager_ID: managerId, name, username });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getManagerById = async (req, res) => {
  const { id } = req.params;
  console.log(req.params);
  try {
    const manager = await Manager.getById(id);
    if (manager) {
      res.json(manager);
    } else {
      res.status(404).json({ message: 'Manager not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateManagerBranchId = async (req, res) => {
  const { id } = req.params;
  const { Branch_ID } = req.body;
  
  try {
    const affectedRows = await Manager.updateBranchId(id, Branch_ID);
    if (affectedRows) {
      res.json({ message: 'Manager updated successfully' });
    } else {
      res.status(404).json({ message: 'Manager not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteManager = async (req, res) => {
  const { id } = req.params;
  console.log(req.params);
  try {
    const affectedRows = await Manager.delete(id);
    if (affectedRows) {
      res.json({ message: 'Manager deleted successfully' });
    } else {
      res.status(404).json({ message: 'Manager not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.loginManager = async (req, res) => {
  const { username, password } = req.body;
  console.log(req.body);
  try {
    const manager = await Manager.getByUsername(username);
    
    if (!manager) {
      return res.status(404).json({ message: 'Ovindu not found' });
    }

    // Compare the provided password with the stored hashed password
    const isPasswordValid = await bcrypt.compare(password, manager.Password);
    
    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }

    // Authentication successful
    res.status(200).json({ message: 'Login successful', Manager_ID: manager.Manager_ID });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
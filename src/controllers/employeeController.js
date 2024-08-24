const Employee = require('../models/employeeModel');

exports.getAllEmployees = async (req, res) => {
  try {
    const employees = await Employee.getAll();
    res.json(employees);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createEmployee = async (req, res) => {
  const { Branch_ID } = req.body;
  try {
    const employeeId = await Employee.create(Branch_ID);
    res.status(201).json({ ID: employeeId, Branch_ID });
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
const FD = require('../models/FDModel');

exports.getAllFDs = async (req, res) => {
  try {
    const fds = await FD.getAll();
    res.json(fds);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createFD = async (req, res) => {
  const { Branch_ID, Customer_ID, Account_ID, Period, StartDate, InitialAmount } = req.body;
  try {
    const fdId = await FD.create(Branch_ID, Customer_ID, Account_ID, Period, StartDate, InitialAmount);
    res.status(201).json({ FD_ID: fdId, Branch_ID, Customer_ID, Account_ID, Period, StartDate, InitialAmount });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getFDById = async (req, res) => {
  const { id } = req.params;
  try {
    const fd = await FD.getById(id);
    if (fd) {
      res.json(fd);
    } else {
      res.status(404).json({ message: 'FD not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateFD = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  try {
    const affectedRows = await FD.update(id, updates);
    if (affectedRows) {
      res.json({ message: 'FD updated successfully' });
    } else {
      res.status(404).json({ message: 'FD not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteFD = async (req, res) => {
  const { id } = req.params;
  try {
    const affectedRows = await FD.delete(id);
    if (affectedRows) {
      res.json({ message: 'FD deleted successfully' });
    } else {
      res.status(404).json({ message: 'FD not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
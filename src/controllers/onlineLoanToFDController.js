const OnlineLoanToFD = require('../models/onlineLoanToFDModel');

// Create a new entry
exports.createOnlineLoanToFD = async (req, res) => {
  const { Application_ID, FD_ID } = req.body;
  try {
    const id = await OnlineLoanToFD.create(Application_ID, FD_ID);
    res.status(201).json({ message: 'Online Loan to FD created', id });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get all entries
exports.getAllOnlineLoansToFD = async (req, res) => {
  try {
    const loansToFD = await OnlineLoanToFD.getAll();
    res.json(loansToFD);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get a specific entry by Application_ID and FD_ID
exports.getOnlineLoanToFDById = async (req, res) => {
  // make function
  const { applicationId, fdId } = req.params;
  try {
    const loanToFD = await OnlineLoanToFD.getById(applicationId, fdId);
    if (loanToFD) {
      res.json(loanToFD);
    } else {
      res.status(404).json({ message: 'Online Loan to FD not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Update an entry
exports.updateOnlineLoanToFD = async (req, res) => {
  const { applicationId, fdId } = req.params;
  const { newFD_ID } = req.body;
  try {
    const affectedRows = await OnlineLoanToFD.update(applicationId, fdId, newFD_ID);
    if (affectedRows) {
      res.json({ message: 'Online Loan to FD updated successfully' });
    } else {
      res.status(404).json({ message: 'Online Loan to FD not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Delete an entry
exports.deleteOnlineLoanToFD = async (req, res) => {
  const { applicationId, fdId } = req.params;
  try {
    const affectedRows = await OnlineLoanToFD.delete(applicationId, fdId);
    if (affectedRows) {
      res.json({ message: 'Online Loan to FD deleted successfully' });
    } else {
      res.status(404).json({ message: 'Online Loan to FD not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

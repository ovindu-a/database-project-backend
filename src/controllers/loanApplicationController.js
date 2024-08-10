const LoanApplication = require('../models/loanApplicationModel');

exports.getAllLoanApplications = async (req, res) => {
  try {
    const loanApplications = await LoanApplication.getAll();
    res.json(loanApplications);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createLoanApplication = async (req, res) => {
  const { Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType } = req.body;
  try {
    const applicationId = await LoanApplication.create(Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType);
    res.status(201).json({ Application_ID: applicationId, Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getLoanApplicationById = async (req, res) => {
  const { id } = req.params;
  try {
    const loanApplication = await LoanApplication.getById(id);
    if (loanApplication) {
      res.json(loanApplication);
    } else {
      res.status(404).json({ message: 'Loan Application not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateLoanApplication = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  try {
    const affectedRows = await LoanApplication.update(id, updates);
    if (affectedRows) {
      res.json({ message: 'Loan Application updated successfully' });
    } else {
      res.status(404).json({ message: 'Loan Application not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteLoanApplication = async (req, res) => {
  const { id } = req.params;
  try {
    const affectedRows = await LoanApplication.delete(id);
    if (affectedRows) {
      res.json({ message: 'Loan Application deleted successfully' });
    } else {
      res.status(404).json({ message: 'Loan Application not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
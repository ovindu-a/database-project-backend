const LoanApplication = require('../models/loanApplicationModel');
const Branch = require('../models/branchModel');


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

exports.getAllLoanApplications = async (req, res) => {
  try {
    const loanApplications = await LoanApplication.getAll();
    res.json(loanApplications);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getAllLoanApplicationsByManagerID = async (req, res) => {
  const { id } = req.params;
  console.log('Getting all loan applications for manager', id);
  try {
    const branchId = await Branch.getByManagerID(id);
    console.log('Branch ID:', branchId);
    if (branchId && branchId.Branch_ID) {
      const loanApplications = await LoanApplication.getAllByBranchID(branchId.Branch_ID);
      console.log('Loan Applications:', loanApplications);
      res.json(loanApplications);
    } else {
      res.status(404).json({ message: 'Branch not found', data: [] });
    }
  } catch (error) {
    console.error('Error fetching loan applications:', error);
    res.status(500).json({ error: error.message, data: [] });
  }
};



// New method for approving a loan application
exports.approveLoanApplication = async (req, res) => {
  const { id } = req.params;  // Application_ID
  const { Manager_ID,Approved } = req.body;  // Manager_ID from the request body
  console.log('Approving loan application', id, 'by manager', Manager_ID);

  try {
    // Verify if the manager is assigned to the branch of the loan application
    const branchAndManager = await LoanApplication.getBranchAndManager(id);

    if (!branchAndManager || branchAndManager.Manager_ID !== Manager_ID) {
      return res.status(403).json({ message: 'Manager is not authorized to approve this loan application.' });
    }

    // Update the Approved status to true
    const affectedRows = await LoanApplication.updateApprovalStatus(id, Approved);
    if (affectedRows) {
      res.json({ message: 'Loan application approved successfully.' });
    } else {
      res.status(404).json({ message: 'Loan application not found.' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
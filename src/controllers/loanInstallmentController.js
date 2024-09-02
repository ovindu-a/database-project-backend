const LoanInstallments = require('../models/loanInstallmentModel');

exports.getAllLoanInstallments = async (req, res) => {
  try {
    const loanInstallments = await LoanInstallments.getAll();
    res.json(loanInstallments);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createLoanInstallment = async (req, res) => {
  const { Loan_ID, Branch_ID, Transaction_ID, DueDate, Value } = req.body;
  try {
    const installmentId = await LoanInstallments.create(Loan_ID, Branch_ID, Transaction_ID, DueDate, Value);
    res.status(201).json({ Installment_ID: installmentId, Loan_ID, Branch_ID, Transaction_ID, DueDate, Value });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getLoanInstallmentById = async (req, res) => {
  const { id } = req.params;
  try {
    const loanInstallment = await LoanInstallments.getById(id);
    if (loanInstallment) {
      res.json(loanInstallment);
    } else {
      res.status(404).json({ message: 'Loan Installment not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateLoanInstallment = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  try {
    const affectedRows = await LoanInstallments.update(id, updates);
    if (affectedRows) {
      res.json({ message: 'Loan Installment updated successfully' });
    } else {
      res.status(404).json({ message: 'Loan Installment not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteLoanInstallment = async (req, res) => {
  const { id } = req.params;
  try {
    const affectedRows = await LoanInstallments.delete(id);
    if (affectedRows) {
      res.json({ message: 'Loan Installment deleted successfully' });
    } else {
      res.status(404).json({ message: 'Loan Installment not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getLoanInstallmentsByLoanId = async (req, res) => {
  const { Loan_ID } = req.params;
  try {
    const loanInstallments = await LoanInstallments.getByLoanId(Loan_ID);
    if (loanInstallments) {
      res.json(loanInstallments);
    } else {
      res.status(404).json({ message: 'No loan installments found for this loan' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

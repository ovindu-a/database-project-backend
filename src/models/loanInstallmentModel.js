const db = require('../config/db');

const LoanInstallments = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM LoanInstallments');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value) => {
    try {
      const [result] = await db.query(
        'INSERT INTO LoanInstallments (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value) VALUES (?, ?, ?, ?, ?)',
        [Loan_ID, Branch_ID, Transaction_ID, DueDate, Value]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Installment_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM LoanInstallments WHERE Installment_ID = ?', [Installment_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (Installment_ID, updates) => {
    const { Loan_ID, Branch_ID, Transaction_ID, DueDate, Value } = updates;
    try {
      const [result] = await db.query(
        'UPDATE LoanInstallments SET Loan_ID = ?, Branch_ID = ?, Transaction_ID = ?, DueDate = ?, Value = ? WHERE Installment_ID = ?',
        [Loan_ID, Branch_ID, Transaction_ID, DueDate, Value, Installment_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (Installment_ID) => {
    try {
      const [result] = await db.query('DELETE FROM LoanInstallments WHERE Installment_ID = ?', [Installment_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getByLoanId: async (Loan_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM LoanInstallments WHERE Loan_ID = ?', [Loan_ID]);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  getLate: async (Branch_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM LoanInstallments WHERE Branch_ID = ? AND Transaction_ID IS NULL AND DueDate< CURDATE()', [Branch_ID]);
      return rows;
    } catch (error) {
      throw error;
    }
  }
};

module.exports = LoanInstallments;
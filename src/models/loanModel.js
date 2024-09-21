const db = require('../config/db');
const LoanInstallments = require('./loanInstallmentModel'); // Import LoanInstallments model

const Loan = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM Loan');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID) => {
    try {
      const [result] = await db.query(
        'INSERT INTO Loan (Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID]
      );
      const loanId = result.insertId;

      // Create loan installments after loan creation
      await LoanInstallments.createLoanInstallmentsSet(loanId, Branch_ID, LoanPeriod, InterestRate, LoanValue, Date);

      return loanId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Loan_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM Loan WHERE Loan_ID = ?', [Loan_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (Loan_ID, updates) => {
    const { Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID } = updates;
    try {
      const [result] = await db.query(
        'UPDATE Loan SET Branch_ID = ?, Customer_ID = ?, LoanPeriod = ?, InterestRate = ?, Date = ?, LoanValue = ?, Application_ID = ? WHERE Loan_ID = ?',
        [Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID, Loan_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (Loan_ID) => {
    try {
      const [result] = await db.query('DELETE FROM Loan WHERE Loan_ID = ?', [Loan_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getLoansByCustomer: async (Customer_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM Loan WHERE Customer_ID = ?', [Customer_ID]);
      return rows;
    } catch (error) {
      throw error;
    }
  },
};

module.exports = Loan;
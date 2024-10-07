const db = require('../config/db');
const LoanInstallments = require('./loanInstallmentModel'); // Import LoanInstallments model
const LoanApplication = require('./loanApplicationModel'); // Import LoanApplication model
const FD = require('./FDModel'); // Import FD model
const OnlineLoanToFD = require('./onlineLoanToFDModel'); // Import OnlineLoanToFD model
const { getByCustomer_opt } = require('./accountModel');

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

  getLoansConnectedToFD: async () => {
    const query = `
      SELECT 
          l.Loan_ID, 
          l.Branch_ID, 
          l.Customer_ID, 
          l.LoanPeriod, 
          l.InterestRate, 
          l.Date AS LoanDate, 
          l.LoanValue, 
          la.Application_ID, 
          la.LoanType, 
          f.FD_ID, 
          f.Branch_ID AS FD_Branch_ID, 
          f.Account_ID, 
          f.Period AS FD_Period, 
          f.StartDate AS FD_StartDate, 
          f.InitialAmount AS FD_InitialAmount
      FROM 
          Loan l
      JOIN 
          LoanApplication la ON l.Application_ID = la.Application_ID
      JOIN 
          Online_loan_to_FD olf ON la.Application_ID = olf.Application_ID
      JOIN 
          FD f ON olf.FD_ID = f.FD_ID
      WHERE 
          la.LoanType = 'Online';
    `;
  
    try {
      const [rows] = await db.query(query);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  getTotalLoanValueConnectedToFD: async () => {
    const query = `
      SELECT 
          SUM(l.LoanValue) AS TotalLoanValue
      FROM 
          Loan l
      JOIN 
          LoanApplication la ON l.Application_ID = la.Application_ID
      JOIN 
          Online_loan_to_FD olf ON la.Application_ID = olf.Application_ID
      JOIN 
          FD f ON olf.FD_ID = f.FD_ID
      WHERE 
          la.LoanType = 'Online';
    `;

    try {
      const [rows] = await db.query(query);
      return rows[0].TotalLoanValue || 0; // Return 0 if no loans are found
    } catch (error) {
      throw error;
    }
  },

  getTotalLoanValueByFD: async (FD_ID) => {
    const query = `
      SELECT 
          SUM(l.LoanValue) AS TotalLoanValue
      FROM 
          Loan l
      JOIN 
          LoanApplication la ON l.Application_ID = la.Application_ID
      JOIN 
          Online_loan_to_FD olf ON la.Application_ID = olf.Application_ID
      WHERE 
          olf.FD_ID = ? AND la.LoanType = 'Online';
    `;

    try {
      const [rows] = await db.query(query, [FD_ID]);
      return rows[0].TotalLoanValue || 0; // Return 0 if no loans are found
    } catch (error) {
      throw error;
    }
  },

  getFDLoanDetails: async (FD_ID) => {
    const query = `
      SELECT 
          f.InitialAmount,
          COALESCE(SUM(l.LoanValue), 0) AS TotalLoansAgainstFD
      FROM 
          FD f
      LEFT JOIN 
          Loan l ON f.FD_ID = l.FD_ID
      WHERE 
          f.FD_ID = ?;
    `;

    try {
      const [rows] = await db.query(query, [FD_ID]);
      return rows[0]; // Return the FD details along with total loans against it
    } catch (error) {
      throw error;
    }
  },

  createQuickLoan: async (Branch_ID, Customer_ID, LoanPeriod, InterestRate, StartDate, LoanValue, FD_ID) => {
    try {
      // Get the total loan value already taken against the specified FD
      // console.log(FD_ID)
      StartDate = new Date(StartDate);
      const existingLoans = await Loan.getTotalLoanValueByFD(FD_ID);
      const fdDetails = await FD.getById(FD_ID); // Assuming this method exists to get FD details
      // console.log(fdDetails)
      const maxLoanValue = fdDetails.InitialAmount * 0.6; // 60% of FD amount

      // Check if the requested loan value exceeds the allowed limit
      if (existingLoans + LoanValue > maxLoanValue) {
        throw new Error(`Requested loan value exceeds the maximum allowed limit of ${maxLoanValue}.`);
      }

      const loanApplicationId = await LoanApplication.create(Branch_ID, Customer_ID, LoanPeriod, StartDate, LoanValue, 1, 'Online'); // Adjust parameters as needed
      var loanId;
      console.log(loanApplicationId)
      const affectedRows = await LoanApplication.updateApprovalStatus(loanApplicationId, 1);
      if (affectedRows) {
        // Create the loan after approval
        const loanDate = new Date(); // Set the loan creation date to today
        loanId = await Loan.create(Branch_ID, Customer_ID, LoanPeriod, InterestRate, loanDate, LoanValue, loanApplicationId); // Create the loan
        await OnlineLoanToFD.create(loanApplicationId, FD_ID); 
      }


      return loanId;
    } catch (error) {
      console.log(error)
      throw error;
    }
  },

  getByCustomer_opt: async (Customer_ID) => {
    try {
      const [rows] = await db.query('SELECT Loan_ID, LoanValue FROM Loan WHERE Customer_ID = ?', [Customer_ID]);
      return rows;
    } catch (error) {
      throw error;
    }
  }
};

module.exports = Loan;
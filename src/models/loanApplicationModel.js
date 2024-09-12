const db = require('../config/db');

const LoanApplication = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM LoanApplication');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType) => {
    try {
      const [result] = await db.query(
        'INSERT INTO LoanApplication (Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Application_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM LoanApplication WHERE Application_ID = ?', [Application_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (Application_ID, updates) => {
    const { Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType } = updates;
    try {
      const [result] = await db.query(
        'UPDATE LoanApplication SET Branch_ID = ?, Customer_ID = ?, LoanPeriod = ?, Date = ?, LoanValue = ?, Approved = ?, LoanType = ? WHERE Application_ID = ?',
        [Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType, Application_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (Application_ID) => {
    try {
      const [result] = await db.query('DELETE FROM LoanApplication WHERE Application_ID = ?', [Application_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  }, 

  updateApprovalStatus: async (Application_ID, Approved) => {
    try {
      const [result] = await db.query(
        'UPDATE LoanApplication SET Approved = ? WHERE Application_ID = ?',
        [Approved, Application_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getBranchAndManager: async (Application_ID) => {
    try {
      const [rows] = await db.query(
        `SELECT la.Branch_ID, m.Manager_ID 
         FROM LoanApplication la 
         JOIN Branch b ON la.Branch_ID = b.Branch_ID 
         JOIN Manager m ON b.Manager_ID = m.Manager_ID 
         WHERE la.Application_ID = ?`,
        [Application_ID]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  getAllByBranchID: async (Branch_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM LoanApplication WHERE Branch_ID = ?', [Branch_ID]);
      return rows ;
      
    } catch (error) {
      throw error;
    }
  },


};



module.exports = LoanApplication;
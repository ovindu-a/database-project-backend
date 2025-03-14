const db = require('../config/db');


const Transaction = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM Transaction');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (FromAccount, ToAccount, Date, Value, Type) => {
    try {
      const [result] = await db.query(
        'INSERT INTO Transaction (FromAccount, ToAccount, Date, Value, Type) VALUES (?, ?, ?, ?, ?)',
        [FromAccount, ToAccount, Date, Value, Type]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Transaction_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM Transaction WHERE Transaction_ID = ?', [Transaction_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (Transaction_ID, updates) => {
    const { FromAccount, ToAccount, Date, Value, Type } = updates;
    try {
      const [result] = await db.query(
        'UPDATE Transaction SET FromAccount = ?, ToAccount = ?, Date = ?, Value = ?, Type = ? WHERE Transaction_ID = ?',
        [FromAccount, ToAccount, Date, Value, Type, Transaction_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (Transaction_ID) => {
    try {
      const [result] = await db.query('DELETE FROM Transaction WHERE Transaction_ID = ?', [Transaction_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getBySentAccount: async (fromAccount) => {
    try {
      const [rows] = await db.query('SELECT * FROM Transaction WHERE FromAccount = ?', [fromAccount]);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  getByReceivedAccount: async (toAccount) => {
    try {
      const [rows] = await db.query('SELECT * FROM Transaction WHERE ToAccount = ?', [toAccount]);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  outgoingReport: async (id,startDate,endDate) => {
    try {
      const [rows] = await db.query(
        'CALL GetOutgoingReport(?, ?, ?)', 
        [id,startDate,endDate]);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  incomingReport: async (id,startDate,endDate) => {
    try {
      const [rows] = await db.query(
        'CALL GetIncomingReport(?, ?, ?)', 
        [id,startDate,endDate]);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  getTransactionTotals: async (managerId) => {
    try {
      // Fetch the Branch_ID using the managerId
      const [branchResult] = await db.query(
        `SELECT branchId_by_managerId(?) AS Branch_ID`, [managerId]
      );
      
      const branchId = branchResult[0].Branch_ID;
  
      // Now fetch the transaction totals for the branch
      const [rows] = await db.query(
        `CALL GetBranchTransactionSummary(?)`,
        [branchId]
      );
      
      return rows[0];
    } catch (error) {
      throw error;
    }
  }
};

module.exports = Transaction;
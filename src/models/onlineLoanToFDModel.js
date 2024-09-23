const db = require('../config/db');

const OnlineLoanToFD = {
  // Create a new entry
  create: async (Application_ID, FD_ID) => {
    try {
      const [result] = await db.query(
        'INSERT INTO Online_loan_to_FD (Application_ID, FD_ID) VALUES (?, ?)',
        [Application_ID, FD_ID]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  // Get all entries
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM Online_loan_to_FD');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  // Get a specific entry by Application_ID and FD_ID
  getById: async (Application_ID, FD_ID) => {
    try {
      const [rows] = await db.query(
        'SELECT * FROM Online_loan_to_FD WHERE Application_ID = ? AND FD_ID = ?',
        [Application_ID, FD_ID]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  // Update an entry
  update: async (Application_ID, FD_ID, newFD_ID) => {
    try {
      const [result] = await db.query(
        'UPDATE Online_loan_to_FD SET FD_ID = ? WHERE Application_ID = ? AND FD_ID = ?',
        [newFD_ID, Application_ID, FD_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  // Delete an entry
  delete: async (Application_ID, FD_ID) => {
    try {
      const [result] = await db.query(
        'DELETE FROM Online_loan_to_FD WHERE Application_ID = ? AND FD_ID = ?',
        [Application_ID, FD_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  }
};

module.exports = OnlineLoanToFD;

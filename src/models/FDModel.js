const db = require('../config/db');
const { getByCustomer_opt } = require('./accountModel');

const FD = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM FD');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Branch_ID, Account_ID, Period, StartDate, InitialAmount) => {
    try {
      const [result] = await db.query(
        'INSERT INTO FD (Branch_ID, Account_ID, Period, StartDate, InitialAmount) VALUES (?, ?, ?, ?, ?)',
        [Branch_ID, Account_ID, Period, StartDate, InitialAmount]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (FD_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM FD WHERE FD_ID = ?', [FD_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (FD_ID, updates) => {
    const { Branch_ID, Customer_ID, Account_ID, Period, StartDate, InitialAmount } = updates;
    try {
      const [result] = await db.query(
        'UPDATE FD SET Branch_ID = ?, Customer_ID = ?, Account_ID = ?, Period = ?, StartDate = ?, InitialAmount = ? WHERE FD_ID = ?',
        [Branch_ID, Customer_ID, Account_ID, Period, StartDate, InitialAmount, FD_ID]
      );
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (FD_ID) => {
    try {
      const [result] = await db.query('DELETE FROM FD WHERE FD_ID = ?', [FD_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getFDsByCustomerId: async (Customer_ID) => {
    // todo : make procedure
    try {
      const query = `
        SELECT fd.*
        FROM FD fd
        JOIN Account a ON fd.Account_ID = a.Account_ID
        WHERE a.Customer_ID = ?
      `;
      const [rows] = await db.query(query, [Customer_ID]);
      return rows;
    } catch (error) {
      throw error;
    }
  }
};

module.exports = FD;
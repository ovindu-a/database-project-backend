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
  }
};

module.exports = Transaction;
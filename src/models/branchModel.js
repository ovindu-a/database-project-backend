const db = require('../config/db');

const Branch = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM Branch');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Name, Address, Manager_ID) => {
    try {
      const [result] = await db.query('INSERT INTO Branch (Name, Address, Manager_ID) VALUES (?, ?, ?)', [Name, Address, Manager_ID]);
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Branch_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM Branch WHERE Branch_ID = ?', [Branch_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (Branch_ID, updates) => {
    const { Name, Address, Manager_ID } = updates;
    try {
      const [result] = await db.query('UPDATE Branch SET Name = ?, Address = ?, Manager_ID = ? WHERE Branch_ID = ?', [Name, Address, Manager_ID, Branch_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (Branch_ID) => {
    try {
      const [result] = await db.query('DELETE FROM Branch WHERE Branch_ID = ?', [Branch_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getByManagerID: async (Manager_ID) => {
    try {
      // Call the stored procedure 'GetBranchByManagerID'
      const [rows] = await db.query('CALL GetBranchByManagerID(?)', [Manager_ID]);
      return rows[0]; // Assuming you want the first row (Branch_ID)
    } catch (error) {
      throw error;
    }
  }
};

module.exports = Branch;
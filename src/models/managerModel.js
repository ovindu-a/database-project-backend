const db = require('../config/db');

const Manager = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM Manager');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async () => {
    try {
      const [result] = await db.query('INSERT INTO Manager () VALUES ()');
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Manager_ID) => {
    try {
      const [rows] = await db.query('SELECT Manager_ID,Name FROM Manager WHERE Manager_ID = ?', [Manager_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  delete: async (Manager_ID) => {
    try {
      const [result] = await db.query('DELETE FROM Manager WHERE Manager_ID = ?', [Manager_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  }
};

module.exports = Manager;
const db = require('../config/db');

const Employee = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM EmployeeView');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Branch_ID, name, username, password) => {
    try {
      const [result] = await db.query(
        'INSERT INTO Employee (Branch_ID, Name, Username, Password) VALUES (?, ?, ?, ?)',
        [Branch_ID, name, username, password]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM EmployeeView WHERE Employee_ID = ?', [ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (ID, updates) => {
    const { Branch_ID } = updates;
    try {
      const [result] = await db.query('UPDATE Employee SET Branch_ID = ? WHERE ID = ?', [Branch_ID, ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (ID) => {
    try {
      const [result] = await db.query('DELETE FROM Employee WHERE Employee_ID = ?', [ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getByUsername: async (username) => {
    try {
      const [rows] = await db.query('SELECT * FROM Employee WHERE Username = ?', [username]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },
};

module.exports = Employee;
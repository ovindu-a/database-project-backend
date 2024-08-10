const db = require('../config/db');

const Customer = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM Customer');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Name, NIC, Address) => {
    try {
      const [result] = await db.query('INSERT INTO Customer (Name, NIC, Address) VALUES (?, ?, ?)', [Name, NIC, Address]);
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Customer_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM Customer WHERE Customer_ID = ?', [Customer_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (Customer_ID, updates) => {
    const { Name, NIC, Address } = updates;
    try {
      const [result] = await db.query('UPDATE Customer SET Name = ?, NIC = ?, Address = ? WHERE Customer_ID = ?', [Name, NIC, Address, Customer_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (Customer_ID) => {
    try {
      const [result] = await db.query('DELETE FROM Customer WHERE Customer_ID = ?', [Customer_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  }
};

module.exports = Customer;
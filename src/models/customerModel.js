const db = require('../config/db');
const { getByLoanId } = require('./loanInstallmentModel');

const Customer = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM CustomerView');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Name, NIC, Address, username, password, CustomerType = 'Personal') => {
    try {
      const [result] = await db.query(
        'INSERT INTO Customer (Name, NIC, Address, Username, Password, CustomerType) VALUES (?, ?, ?, ?, ?, ?)',
        [Name, NIC, Address, username, password, CustomerType]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Customer_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM CustomerView WHERE Customer_ID = ?', [Customer_ID]);
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
  },

  getByUsername: async (username) => {
    try {
      const [rows] = await db.query('SELECT * FROM Customer WHERE Username = ?', [username]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  getByLoanId: async (Loan_ID) => {
    try {
      const [Customer_ID] = await db.query('SELECT Customer_ID FROM Loan WHERE Loan_ID = ?', [Loan_ID]);
      const [rows] = await db.query('SELECT Customer_ID,Name FROM Customer WHERE Customer_ID = ?', [Customer_ID[0].Customer_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  getById_opt: async (Customer_ID) => {
    try {
      const [rows] = await db.query('SELECT Name,NIC,Address,CustomerType FROM CustomerView WHERE Customer_ID = ?', [Customer_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

    // Search customer by email
    getByEmail: async (email) => {
      try {
        const [rows] = await db.query('SELECT * FROM Customer WHERE Email = ?', [email]);
        return rows[0];
      } catch (error) {
        throw error;
      }
    },
  
    // Search customer by username
    getByUsername: async (username) => {
      try {
        const [rows] = await db.query('SELECT * FROM Customer WHERE Username = ?', [username]);
        return rows[0];
      } catch (error) {
        throw error;
      }
    }, 

    // Search customer by NIC
    getByNIC: async (NIC) => {
      try {
        const [rows] = await db.query('SELECT * FROM Customer WHERE NIC = ?', [NIC]);
        return rows[0];
      } catch (error) {
        throw error;
      }
    },
};

module.exports = Customer;
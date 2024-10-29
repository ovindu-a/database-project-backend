const db = require('../config/db');

const Account = {
  getAll: async () => {
    try {
      const [rows] = await db.query('SELECT * FROM Account');
      return rows;
    } catch (error) {
      throw error;
    }
  },

  create: async (Branch_ID, Customer_ID, Type, Balance, OpeningDate, Plan) => {
    try {
      const [result] = await db.query(
        'INSERT INTO Account (Branch_ID, Customer_ID, Type, Balance, OpeningDate, Plan) VALUES (?, ?, ?, ?, ?, ?)',
        [Branch_ID, Customer_ID, Type, Balance, OpeningDate, Plan]
      );
      return result.insertId;
    } catch (error) {
      throw error;
    }
  },

  getById: async (Account_ID) => {
    try {
      console.log(Account_ID);
      const [rows] = await db.query('SELECT * FROM Account WHERE Account_ID = ?', [Account_ID]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  update: async (Account_ID, updates) => {
    const { Branch_ID, Customer_ID, Type, Balance } = updates;
    try {
      const [result] = await db.query('UPDATE Account SET Branch_ID = ?, Customer_ID = ?, Type = ?, Balance = ? WHERE Account_ID = ?', [Branch_ID, Customer_ID, Type, Balance, Account_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  delete: async (Account_ID) => {
    try {
      const [result] = await db.query('DELETE FROM Account WHERE Account_ID = ?', [Account_ID]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  // get account by customer id
  getByCustomer: async (Customer_ID) => {
    try {
      const [rows] = await db.query('SELECT * FROM Account WHERE Customer_ID = ?', [Customer_ID]);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  updateBalance: async (accountId, amount) => {
    try {
      const [result] = await db.query(
        'UPDATE Account SET Balance = Balance + ? WHERE Account_ID = ?',
        [amount, accountId]
      );
      return result.affectedRows; // Return the number of affected rows
    } catch (error) {
      throw error;
    }
  },
  
  withdraw: async (accountId, amount) => {
    // TODO: make procedure
    try {
      // First, check if the account has sufficient balance
      const [account] = await db.query('SELECT Balance FROM Account WHERE Account_ID = ?', [accountId]);

      if (account.length === 0) {
        throw new Error('Account not found');
      }

      const currentBalance = account[0].Balance;

      if (currentBalance < amount) {
        throw new Error('Insufficient balance');
      }

      // Update the balance by subtracting the amount
      const [result] = await db.query(
        'UPDATE Account SET Balance = Balance - ? WHERE Account_ID = ?',
        [amount, accountId]
      );

      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  },

  getByCustomer_opt: async (Customer_ID) => {
    try {
      const [rows] = await db.query('SELECT Account_ID,Balance FROM Account WHERE Customer_ID = ?', [Customer_ID]);
      return rows;
    } catch (error) {
      throw error;
    }
  },

  // Get customer by account number
  getCustomerByAccountNumber: async (accountId) => {
    try {
      const [rows] = await db.query(
        `SELECT c.* FROM Customer c 
          JOIN Account a ON c.Customer_ID = a.Customer_ID 
          WHERE a.Account_ID = ?`,
        [accountId]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  }
};

module.exports = Account;
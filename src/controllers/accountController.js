const { type } = require('express/lib/response');
const Account = require('../models/accountModel');
const Transaction = require('../models/transactionModel');
const { generateInterestTransactions } = require('../utils/interestCalculator');

exports.getAllAccounts = async (req, res) => {
  try {
    const accounts = await Account.getAll();
    res.json(accounts);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createAccount = async (req, res) => {
  const { Branch_ID, Customer_ID, Type, Balance, OpeningDate, Plan } = req.body;
  try {
    const accountId = await Account.create(Branch_ID, Customer_ID, Type, Balance, OpeningDate, Plan);

    console.log('Type:', Type);

    // Generate monthly interest transactions based on Plan
    if (Type === 'Savings') {
      await generateInterestTransactions(accountId, Balance, OpeningDate, Plan);
    }

    res.status(201).json({ Account_ID: accountId, Branch_ID, Customer_ID, Type, Balance, OpeningDate, Plan });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getAccountById = async (req, res) => {
  const { id } = req.params;
  try {
    const account = await Account.getById(id);
    if (account) {
      res.json(account);
    } else {
      res.status(404).json({ message: 'Account not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getByCustomer = async (req, res) => {
  const { customer } = req.params;
  try {
    const accounts = await Account.getByCustomer(customer);
    res.json(accounts);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.withdrawFromAccount = async (req, res) => {
  const { accountId } = req.params; // Account ID from the URL
  const { amount } = req.body; // Amount to withdraw from the request body

  try {
    // Make the withdrawal
    const affectedRows = await Account.withdraw(accountId, amount);
    if (affectedRows) {
      // Create a transaction after the successful withdrawal
      await Transaction.create(accountId, null, new Date(), amount, 'ATM Withdrawal'); // Assuming null for ToAccount as it is an ATM withdrawal
      
      res.json({ message: `Withdrawal of ${amount} from account ${accountId} successful.` });
    } else {
      res.status(404).json({ message: 'Account not found or withdrawal failed.' });
    }
  } catch (error) {
    if (error.message === 'Insufficient balance') {
      res.status(400).json({ error: 'Insufficient balance.' });
    } else if (error.message === 'Account not found') {
      res.status(404).json({ error: 'Account not found.' });
    } else {
      res.status(500).json({ error: error.message });
    }
  }
};

const Transaction = require('../models/transactionModel');

exports.getAllTransactions = async (req, res) => {
  console.log('getAllTransactions')
  try {
    const transactions = await Transaction.getAll();
    res.json(transactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createTransaction = async (req, res) => {
  const { FromAccount, ToAccount, Date, Value, Type } = req.body;
  try {
    const transactionId = await Transaction.create(FromAccount, ToAccount, Date, Value, Type);
    res.status(201).json({ Transaction_ID: transactionId, FromAccount, ToAccount, Date, Value, Type });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getTransactionById = async (req, res) => {
  const { id } = req.params;
  try {
    const transaction = await Transaction.getById(id);
    if (transaction) {
      res.json(transaction);
    } else {
      res.status(404).json({ message: 'Transaction not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateTransaction = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  try {
    const affectedRows = await Transaction.update(id, updates);
    if (affectedRows) {
      res.json({ message: 'Transaction updated successfully' });
    } else {
      res.status(404).json({ message: 'Transaction not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteTransaction = async (req, res) => {
  const { id } = req.params;
  try {
    const affectedRows = await Transaction.delete(id);
    if (affectedRows) {
      res.json({ message: 'Transaction deleted successfully' });
    } else {
      res.status(404).json({ message: 'Transaction not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }

  
};

exports.getTransactionsBySentAccount = async (req, res) => {
  const { account } = req.params;
  try {
    const transactions = await Transaction.getBySentAccount(account);
    res.json(transactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getTransactionsByReceivedAccount = async (req, res) => {
  const { account } = req.params;
  try {
    const transactions = await Transaction.getByReceivedAccount(account);
    res.json(transactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.getTransactionsByAccount = async (req, res) => {
  const { account } = req.params;

  try {
    const fromAccountTransactions = await Transaction.getBySentAccount(account);
    const toAccountTransactions = await Transaction.getByReceivedAccount(account);

    // Combine the results
    let combinedTransactions = [...fromAccountTransactions, ...toAccountTransactions];

    // Sort the combined results by Date
    combinedTransactions.sort((a, b) => new Date(a.Date) - new Date(b.Date));

    res.json(combinedTransactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
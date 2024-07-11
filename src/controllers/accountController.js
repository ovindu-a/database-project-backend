const Account = require('../models/accountModel');

exports.getAllAccounts = async (req, res) => {
  try {
    const accounts = await Account.getAll();
    res.json(accounts);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createAccount = async (req, res) => {
  const { Branch_ID, Customer_ID, Type, Balance } = req.body;
  try {
    const accountId = await Account.create(Branch_ID, Customer_ID, Type, Balance);
    res.status(201).json({ Account_ID: accountId, Branch_ID, Customer_ID, Type, Balance });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
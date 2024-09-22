const Transaction = require('../models/transactionModel');
const Branch = require('../models/branchModel');

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
  console.log('Ready to give transactions for account:', account);

  try {
    const fromAccountTransactions = await Transaction.getBySentAccount(account);
    const toAccountTransactions = await Transaction.getByReceivedAccount(account);

    // Combine the results
    let combinedTransactions = [...fromAccountTransactions, ...toAccountTransactions];

    // Sort the combined results by Date
    // combinedTransactions.sort((a, b) => new Date(a.Date) - new Date(b.Date));//
    

    res.json(combinedTransactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getAllLoanApplicationsByManagerID = async (req, res) => {
  const { id } = req.params;
  console.log('Getting all loan applications for manager', id);
  try {
    const branchId = await Branch.getByManagerID(id);
    console.log('Branch ID:', branchId);
    if (branchId && branchId.Branch_ID) {
      const loanApplications = await LoanApplication.getAllByBranchID(branchId.Branch_ID);
      console.log('Loan Applications:', loanApplications);
      res.status(200).json(loanApplications );
    } else {
      res.status(404).json(loanApplications);
    }
  } catch (error) {
    console.error('Error fetching loan applications:', error);
    res.status(500).json({ error: error.message, data: [] });
  }
};

exports.getOutgoingReport = async (req, res) => {
  const { id } = req.params;
  const { startDate, endDate } = req.body;

  let Branch_ID;
  try {
    Branch_ID = await Branch.getByManagerID(id);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }

  try {
    const transactions = await Transaction.outgoingReport(Branch_ID.Branch_ID, startDate, endDate);
    res.json(transactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }

}

exports.getIncomingReport = async (req, res) => {
  const { id } = req.params;
  const { startDate, endDate } = req.body;

  console.log('Incoming report for manager', id, 'from', startDate, 'to', endDate);

  let Branch_ID;
  try {
    Branch_ID = await Branch.getByManagerID(id);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }

  try {
    const transactions = await Transaction.incomingReport(Branch_ID.Branch_ID, startDate, endDate);
    res.json(transactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }

}
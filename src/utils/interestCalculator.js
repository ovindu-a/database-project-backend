const Transaction = require('../models/transactionModel');

const generateInterestTransactions = async (accountId, initialBalance, openingDate, planType) => {
  let interestRate;
  let minimumBalance;

  // print the planType
    console.log('PlanType:', planType);   

  // Determine interest rate and minimum balance based on PlanType
  switch (planType) {
    case 'Children':
      interestRate = (12**(1/12))/100; // 12%
      minimumBalance = 0;  // No minimum
      break;
    case 'Teen':
      interestRate = (11**(1/12))/100; // 11%
      minimumBalance = 500;
      break;
    case 'Adult':
      interestRate = (10**(1/12))/100; // 10%
      minimumBalance = 1000;
      break;
    case 'Senior':
      interestRate = (13**(1/12))/100; // 13%
      minimumBalance = 1000;
      break;
    default:
      throw new Error('Invalid PlanType');
  }

  let currentBalance = initialBalance;

  const startDate = new Date(openingDate);
  const endDate = new Date();

  console.log("Rate", interestRate);
  while (startDate < endDate) {
    // Only apply interest if the balance meets or exceeds the minimum balance requirement
    if (currentBalance >= minimumBalance) {
      const interest = currentBalance * interestRate;
      console.log('Interest:', interest);

      currentBalance += interest;

      // Create a transaction record for this month's interest
      await Transaction.create(accountId, null, startDate.toISOString().split('T')[0], interest, 'Interest Payment');
    }

    // Move to the next month
    startDate.setMonth(startDate.getMonth() + 1);
  }
};

module.exports = {
    generateInterestTransactions,
  };
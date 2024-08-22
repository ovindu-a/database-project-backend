const express = require('express');
const router = express.Router();
const transactionController = require('../controllers/transactionController');

router.get('/', transactionController.getAllTransactions);
router.post('/', transactionController.createTransaction);
router.get('/:id', transactionController.getTransactionById);
router.put('/:id', transactionController.updateTransaction);
router.delete('/:id', transactionController.deleteTransaction);
router.get('/fromAccount/:account', transactionController.getTransactionsBySentAccount);
router.get('/toAccount/:account', transactionController.getTransactionsByReceivedAccount);
router.get('/byAccount/:account', transactionController.getTransactionsByAccount);

module.exports = router;


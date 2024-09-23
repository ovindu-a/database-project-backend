const express = require('express');
const router = express.Router();
const loanController = require('../controllers/loanController');

router.get('/', loanController.getAllLoans);
router.post('/', loanController.createLoan);
router.get('/:id', loanController.getLoanById);
router.put('/:id', loanController.updateLoan);
router.delete('/:id', loanController.deleteLoan);
router.get('/customer/:id', loanController.getLoanByCustomer);
router.post('/quick-loan', loanController.createQuickLoan); // Add this line


module.exports = router;
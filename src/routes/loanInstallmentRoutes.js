const express = require('express');
const router = express.Router();
const loanInstallmentsController = require('../controllers/loanInstallmentController');

router.get('/', loanInstallmentsController.getAllLoanInstallments);
router.post('/', loanInstallmentsController.createLoanInstallment);
router.get('/:id', loanInstallmentsController.getLoanInstallmentById);
router.put('/:id', loanInstallmentsController.updateLoanInstallment);
router.delete('/:id', loanInstallmentsController.deleteLoanInstallment);

module.exports = router;
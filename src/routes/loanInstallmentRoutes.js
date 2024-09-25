const express = require('express');
const router = express.Router();
const loanInstallmentsController = require('../controllers/loanInstallmentController');

router.get('/', loanInstallmentsController.getAllLoanInstallments);
router.post('/', loanInstallmentsController.createLoanInstallment);
router.get('/:id', loanInstallmentsController.getLoanInstallmentById);
router.put('/:id', loanInstallmentsController.updateLoanInstallment);
router.delete('/:id', loanInstallmentsController.deleteLoanInstallment);
router.get('/loan/:id', loanInstallmentsController.getLoanInstallmentsByLoanId)
router.get('/late/:id', loanInstallmentsController.getLateLoans);
router.post('/pay/:installmentId', loanInstallmentsController.makeInstallmentPayment);


module.exports = router;
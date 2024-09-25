const express = require('express');
const router = express.Router();
const loanApplicationController = require('../controllers/loanApplicationController');

router.get('/', loanApplicationController.getAllLoanApplications);
router.post('/', loanApplicationController.createLoanApplication);
router.get('/:id', loanApplicationController.getLoanApplicationById);
router.put('/:id', loanApplicationController.updateLoanApplication);
router.delete('/:id', loanApplicationController.deleteLoanApplication);
router.post('/:id/approve', loanApplicationController.approveLoanApplication);
router.get('/:id/getAll', loanApplicationController.getAllLoanApplicationsByManagerID);
router.get('/:id/getPendingByCustomer', loanApplicationController.getPendingLoanApplicationsByCustomerID);


module.exports = router;
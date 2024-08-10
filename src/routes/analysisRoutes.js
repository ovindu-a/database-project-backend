const express = require('express');
const router = express.Router();
const analysisController = require('../controllers/analysisController');

router.get('/branch-summary/:branchId', analysisController.getAccountSummaryByBranch);
router.get('/customer-distribution', analysisController.getCustomerDistribution);
router.get('/account-summary', analysisController.getCustomerAccountSummary);

module.exports = router;
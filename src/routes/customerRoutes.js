const express = require('express');
const router = express.Router();
const customerController = require('../controllers/customerController');
const { verifyCookie } = require('../middleware/authMiddleware'); // Import the middleware

router.get('/', customerController.getAllCustomers);
router.post('/', customerController.createCustomer);
router.get('/:id', customerController.getCustomerById); // Use the middleware here
router.put('/:id', verifyCookie, customerController.updateCustomer); // Protect this route as well
router.delete('/:id', verifyCookie, customerController.deleteCustomer); // Protect this route as well
router.post('/login', customerController.loginCustomer);
router.post('/verify-otp', customerController.verifyOtp); // Add this line
router.get('/by-loan/:id', customerController.getCustomerByLoanId);


module.exports = router;
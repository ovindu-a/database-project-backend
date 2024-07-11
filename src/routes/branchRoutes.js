const express = require('express');
const router = express.Router();
const branchController = require('../controllers/branchController');

router.get('/', branchController.getAllBranches);
router.post('/', branchController.createBranch);
router.get('/:id', branchController.getBranchById);
router.put('/:id', branchController.updateBranch);
router.delete('/:id', branchController.deleteBranch);

module.exports = router;
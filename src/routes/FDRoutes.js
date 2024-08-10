const express = require('express');
const router = express.Router();
const fdController = require('../controllers/FDController');

router.get('/', fdController.getAllFDs);
router.post('/', fdController.createFD);
router.get('/:id', fdController.getFDById);
router.put('/:id', fdController.updateFD);
router.delete('/:id', fdController.deleteFD);

module.exports = router;
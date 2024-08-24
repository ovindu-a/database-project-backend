const Branch = require('../models/branchModel');
const Manager = require('../models/managerModel');

exports.getAllBranches = async (req, res) => {
  try {
    const branches = await Branch.getAll();
    res.json(branches);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createBranch = async (req, res) => {
  const { Name, Address, Manager_ID } = req.body;
  try {
    // Check if the Manager exists
    const manager = await Manager.getById(Manager_ID);
    if (!manager) {
      return res.status(400).json({ error: "Manager not found" });
    }

    // Create the branch
    const branchId = await Branch.create(Name, Address, Manager_ID);

    res.status(201).json({ Branch_ID: branchId, Name, Address, Manager_ID });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getBranchById = async (req, res) => {
  const { id } = req.params;
  try {
    const branch = await Branch.getById(id);
    if (branch) {
      res.json(branch);
    } else {
      res.status(404).json({ message: 'Branch not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updateBranch = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;
  try {
    const affectedRows = await Branch.update(id, updates);
    if (affectedRows) {
      res.json({ message: 'Branch updated successfully' });
    } else {
      res.status(404).json({ message: 'Branch not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.deleteBranch = async (req, res) => {
  const { id } = req.params;
  try {
    const affectedRows = await Branch.delete(id);
    if (affectedRows) {
      res.json({ message: 'Branch deleted successfully' });
    } else {
      res.status(404).json({ message: 'Branch not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// exports.getBranchByManagerID = async (req, res) => {
//   const { id } = req.params;
//   try {
//     const branch = await Branch.getByManagerID(id);
//     if (branch) {
//       res.json(branch);
//     } else {
//       res.status(404).json({ message: 'Branch not found' });
//     }
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// }
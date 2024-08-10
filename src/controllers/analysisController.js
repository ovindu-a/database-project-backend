const Analysis = require('../models/analysisModel');

exports.getAccountSummaryByBranch = async (req, res) => {
  const { branchId } = req.params;
  try {
    const summary = await Analysis.getAccountSummaryByBranch(branchId);
    res.json(summary);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getCustomerDistribution = async (req, res) => {
  try {
    const distribution = await Analysis.getCustomerDistribution();
    res.json(distribution);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getCustomerAccountSummary = async (req, res) => {
  try {
    const summary = await Analysis.getCustomerAccountSummary();
    res.json(summary);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}
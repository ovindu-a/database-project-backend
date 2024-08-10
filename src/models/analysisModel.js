const db = require('../config/db');

const Analysis = {
    getAccountSummaryByBranch: async (branchId) => {
        const [rows] = await db.query(
            'SELECT Branch_ID, SUM(Balance) as TotalBalance, COUNT(*) as AccountCount FROM Account WHERE Branch_ID = ? GROUP BY Branch_ID',
            [branchId]
        );
        return rows[0];
    },

    getCustomerDistribution: async () => {
        const [rows] = await db.query(
            'SELECT Branch_ID, COUNT(Customer_ID) as CustomerCount FROM Account GROUP BY Branch_ID'
        );
        return rows;
    },


    // get list of users along with number of accounts and total balance
    getCustomerAccountSummary: async () => {
        const [rows] = await db.query(
            'SELECT Customer_ID, COUNT(*) as AccountCount, SUM(Balance) as TotalBalance FROM Account GROUP BY Customer_ID'
        );
        return rows;
    }

};

module.exports = Analysis;
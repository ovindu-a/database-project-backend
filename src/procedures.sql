DELIMITER $$

CREATE PROCEDURE GetBranchByManagerID(IN p_Manager_ID INT)
BEGIN
    SELECT Branch_ID 
    FROM Branch 
    WHERE Manager_ID = p_Manager_ID;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION GetBranchIDByManagerID(p_Manager_ID INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE branch_id INT;

    -- Retrieve Branch_ID based on Manager_ID
    SELECT Branch_ID INTO branch_id
    FROM Branch
    WHERE Manager_ID = p_Manager_ID
    LIMIT 1;

    -- Return the Branch_ID
    RETURN branch_id;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GetFDsByCustomerID(IN p_Customer_ID INT)
BEGIN
    SELECT fd.*
    FROM FD fd
    JOIN Account a ON fd.Account_ID = a.Account_ID
    WHERE a.Customer_ID = p_Customer_ID;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE CreateLoanInstallmentsSet(
    IN p_Loan_ID INT,
    IN p_Branch_ID INT,
    IN p_Loan_Period INT,
    IN p_Interest_Rate DECIMAL(5, 2),
    IN p_Loan_Value DECIMAL(15, 2),
    IN p_Start_Date DATE
)
BEGIN
    DECLARE monthlyInterestRate DECIMAL(10, 5);
    DECLARE numberOfPayments INT;
    DECLARE monthlyInstallment DECIMAL(15, 2);
    DECLARE installmentValue DECIMAL(15, 2);
    DECLARE i INT DEFAULT 1;
    DECLARE dueDate DATE;

    -- Calculate monthly interest rate
    SET monthlyInterestRate = p_Interest_Rate / 1200;

    -- Calculate number of payments (months)
    SET numberOfPayments = p_Loan_Period;

    -- Calculate monthly installment using the amortizing loan formula
    SET monthlyInstallment = (p_Loan_Value * monthlyInterestRate) / (1 - POW(1 + monthlyInterestRate, -numberOfPayments));

    -- Loop through the number of payments to create each installment
    WHILE i <= numberOfPayments DO
        -- Calculate the due date for each installment
        SET dueDate = DATE_ADD(p_Start_Date, INTERVAL i MONTH);

        -- Insert the installment record into the LoanInstallments table
        INSERT INTO LoanInstallments (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value)
        VALUES (p_Loan_ID, p_Branch_ID, NULL, dueDate, ROUND(monthlyInstallment, 2));

        -- Increment loop counter
        SET i = i + 1;
    END WHILE;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GetTotalLoanValueByFD(IN p_FD_ID INT)
BEGIN
    DECLARE totalLoanValue DECIMAL(15, 2) DEFAULT 0;

    -- Calculate the total loan value
    SELECT SUM(l.LoanValue) INTO totalLoanValue
    FROM Loan l
    JOIN LoanApplication la ON l.Application_ID = la.Application_ID
    JOIN Online_loan_to_FD olf ON la.Application_ID = olf.Application_ID
    WHERE olf.FD_ID = p_FD_ID AND la.LoanType = 'Online';

    -- Return the result
    SELECT IFNULL(totalLoanValue, 0) AS TotalLoanValue;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE CreateOnlineLoan(
    IN p_Branch_ID INT,
    IN p_Customer_ID INT,
    IN p_LoanPeriod INT,
    IN p_InterestRate DECIMAL(5, 2),
    IN p_StartDate DATE,
    IN p_LoanValue DECIMAL(15, 2),
    IN p_FD_ID INT
)
BEGIN
    DECLARE existingLoans DECIMAL(15, 2) DEFAULT 0;
    DECLARE maxLoanValue DECIMAL(15, 2);
    DECLARE fdInitialAmount DECIMAL(15, 2);
    DECLARE loanApplicationId INT;
    DECLARE loanId INT;
    DECLARE applicationApproved INT DEFAULT 1;  -- Assuming the loan is approved

    -- Get the total loan value already taken against the specified FD using the function
    SET existingLoans = GetTotalLoanValueByFD(p_FD_ID);

    -- Get the fixed deposit details
    SELECT InitialAmount INTO fdInitialAmount
    FROM FD
    WHERE FD_ID = p_FD_ID;

    -- Calculate the maximum loan value allowed (60% of FD amount)
    SET maxLoanValue = fdInitialAmount * 0.6;

    -- Check if the requested loan value exceeds the allowed limit
    IF (existingLoans + p_LoanValue) > maxLoanValue THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Requested loan value exceeds the maximum allowed limit ';
    ELSE
        -- Insert loan application (assuming it's auto-approved)
        INSERT INTO LoanApplication (Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType)
        VALUES (p_Branch_ID, p_Customer_ID, p_LoanPeriod, p_StartDate, p_LoanValue, applicationApproved, 'Online');
        SET loanApplicationId = LAST_INSERT_ID();

        -- Update loan application approval status
        UPDATE LoanApplication
        SET Approved = 1  -- Assuming the loan is approved after validation
        WHERE Application_ID = loanApplicationId;

        -- Create the loan entry
        INSERT INTO Loan (Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID)
        VALUES (p_Branch_ID, p_Customer_ID, p_LoanPeriod, p_InterestRate, CURDATE(), p_LoanValue, loanApplicationId);
        SET loanId = LAST_INSERT_ID();

        -- Link the loan application to the FD
        INSERT INTO Online_loan_to_FD (Application_ID, FD_ID)
        VALUES (loanApplicationId, p_FD_ID);
    END IF;

    -- Return the loan ID
    SELECT loanId AS Loan_ID;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE ApplyMonthlyInterest()
BEGIN
    -- Temporary table to store the interest transactions with a primary key
    CREATE TEMPORARY TABLE TempInterestTransactions (
        Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
        Account_ID INT,
        InterestAmount DECIMAL(15, 2)
    );

    -- Update the balance for 'Children' plan (12% interest, no minimum balance)
    UPDATE Account
    SET Balance = Balance + (Balance * 0.12 / 100)
    WHERE Type = 'Savings' AND Plan = 'Children' AND Account_ID IS NOT NULL;

    -- Add entries to the temporary table for the 'Children' plan
    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.12 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Children' AND Account_ID IS NOT NULL;

    -- Update the balance for 'Teen' plan (11% interest, minimum balance 500)
    UPDATE Account
    SET Balance = Balance + (Balance * 0.11 / 100)
    WHERE Type = 'Savings' AND Plan = 'Teen' AND Balance >= 500 AND Account_ID IS NOT NULL;

    -- Add entries to the temporary table for the 'Teen' plan
    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.11 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Teen' AND Balance >= 500 AND Account_ID IS NOT NULL;

    -- Update the balance for 'Adult' plan (10% interest, minimum balance 1000)
    UPDATE Account
    SET Balance = Balance + (Balance * 0.10 / 100)
    WHERE Type = 'Savings' AND Plan = 'Adult' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    -- Add entries to the temporary table for the 'Adult' plan
    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.10 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Adult' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    -- Update the balance for 'Senior' plan (13% interest, minimum balance 1000)
    UPDATE Account
    SET Balance = Balance + (Balance * 0.13 / 100)
    WHERE Type = 'Savings' AND Plan = 'Senior' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    -- Add entries to the temporary table for the 'Senior' plan
    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.13 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Senior' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    -- Insert transactions from the temporary table into the Transaction table
    INSERT INTO Transaction (FromAccount, ToAccount, Date, Value, Type)
    SELECT NULL, Account_ID, CURDATE(), InterestAmount, 'Interest'
    FROM TempInterestTransactions;

    -- Drop the temporary table to free up resources
    DROP TEMPORARY TABLE TempInterestTransactions;

END$$

DELIMITER ;


DELIMITER //

CREATE PROCEDURE GetBranchTransactionSummary(IN branchId INT)
BEGIN
    SELECT 
        SUM(CASE WHEN FromAccount IN (SELECT Account_ID FROM Account WHERE Branch_ID = branchId) THEN Value ELSE 0 END) AS totalOutgoing,
        SUM(CASE WHEN ToAccount IN (SELECT Account_ID FROM Account WHERE Branch_ID = branchId) THEN Value ELSE 0 END) AS totalIncoming
    FROM Transaction
    WHERE FromAccount IN (SELECT Account_ID FROM Account WHERE Branch_ID = branchId)
       OR ToAccount IN (SELECT Account_ID FROM Account WHERE Branch_ID = branchId);
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE GetOutgoingReport(
    IN managerId INT, 
    IN startDate DATE, 
    IN endDate DATE
)
BEGIN
    SELECT 
        FromAccount, 
        ToAccount, 
        Date, 
        Value, 
        Account.Type 
    FROM 
        Transaction 
    INNER JOIN 
        Account 
    ON 
        Transaction.FromAccount = Account.Account_ID 
    WHERE 
        Account.Branch_ID = branchId_by_managerId(managerId) 
        AND (Date >= startDate AND Date <= endDate);
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE GetIncomingReport(
    IN managerId INT, 
    IN startDate DATE, 
    IN endDate DATE
)
BEGIN
    SELECT 
        FromAccount, 
        ToAccount, 
        Date, 
        Value, 
        Account.Type 
    FROM 
        Transaction 
    INNER JOIN 
        Account 
    ON 
        Transaction.ToAccount = Account.Account_ID 
    WHERE 
        Account.Branch_ID = branchId_by_managerId(managerId) 
        AND (Date >= startDate AND Date <= endDate);
END //

DELIMITER ;

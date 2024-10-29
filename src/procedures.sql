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

    SELECT Branch_ID INTO branch_id
    FROM Branch
    WHERE Manager_ID = p_Manager_ID
    LIMIT 1;

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

    SET monthlyInterestRate = p_Interest_Rate / 1200;

    SET numberOfPayments = p_Loan_Period;

    SET monthlyInstallment = (p_Loan_Value * monthlyInterestRate) / (1 - POW(1 + monthlyInterestRate, -numberOfPayments));

    WHILE i <= numberOfPayments DO
        SET dueDate = DATE_ADD(p_Start_Date, INTERVAL i MONTH);

        INSERT INTO LoanInstallments (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value)
        VALUES (p_Loan_ID, p_Branch_ID, NULL, dueDate, ROUND(monthlyInstallment, 2));

        SET i = i + 1;
    END WHILE;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GetTotalLoanValueByFD(IN p_FD_ID INT)
BEGIN
    DECLARE totalLoanValue DECIMAL(15, 2) DEFAULT 0;

    SELECT SUM(l.LoanValue) INTO totalLoanValue
    FROM Loan l
    JOIN LoanApplication la ON l.Application_ID = la.Application_ID
    JOIN Online_loan_to_FD olf ON la.Application_ID = olf.Application_ID
    WHERE olf.FD_ID = p_FD_ID AND la.LoanType = 'Online';

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

    SET existingLoans = GetTotalLoanValueByFD(p_FD_ID);

    SELECT InitialAmount INTO fdInitialAmount
    FROM FD
    WHERE FD_ID = p_FD_ID;

    SET maxLoanValue = fdInitialAmount * 0.6;

    IF (existingLoans + p_LoanValue) > maxLoanValue THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Requested loan value exceeds the maximum allowed limit ';
    ELSE
        INSERT INTO LoanApplication (Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType)
        VALUES (p_Branch_ID, p_Customer_ID, p_LoanPeriod, p_StartDate, p_LoanValue, applicationApproved, 'Online');
        SET loanApplicationId = LAST_INSERT_ID();

        UPDATE LoanApplication
        SET Approved = 1  -- Assuming the loan is approved after validation
        WHERE Application_ID = loanApplicationId;

        INSERT INTO Loan (Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID)
        VALUES (p_Branch_ID, p_Customer_ID, p_LoanPeriod, p_InterestRate, CURDATE(), p_LoanValue, loanApplicationId);
        SET loanId = LAST_INSERT_ID();

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
    CREATE TEMPORARY TABLE TempInterestTransactions (
        Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
        Account_ID INT,
        InterestAmount DECIMAL(15, 2)
    );

    UPDATE Account
    SET Balance = Balance + (Balance * 0.12 / 100)
    WHERE Type = 'Savings' AND Plan = 'Children' AND Account_ID IS NOT NULL;

    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.12 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Children' AND Account_ID IS NOT NULL;

    UPDATE Account
    SET Balance = Balance + (Balance * 0.11 / 100)
    WHERE Type = 'Savings' AND Plan = 'Teen' AND Balance >= 500 AND Account_ID IS NOT NULL;

    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.11 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Teen' AND Balance >= 500 AND Account_ID IS NOT NULL;

    UPDATE Account
    SET Balance = Balance + (Balance * 0.10 / 100)
    WHERE Type = 'Savings' AND Plan = 'Adult' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.10 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Adult' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    UPDATE Account
    SET Balance = Balance + (Balance * 0.13 / 100)
    WHERE Type = 'Savings' AND Plan = 'Senior' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    INSERT INTO TempInterestTransactions (Account_ID, InterestAmount)
    SELECT Account_ID, (Balance * 0.13 / 100)
    FROM Account
    WHERE Type = 'Savings' AND Plan = 'Senior' AND Balance >= 1000 AND Account_ID IS NOT NULL;

    INSERT INTO Transaction (FromAccount, ToAccount, Date, Value, Type)
    SELECT NULL, Account_ID, CURDATE(), InterestAmount, 'Interest'
    FROM TempInterestTransactions;

    DROP TEMPORARY TABLE TempInterestTransactions;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE MakeLoanPayment (
    IN p_Installment_ID INT,
    IN p_Account_ID INT,
    IN p_Amount DECIMAL(15, 2)
)
proc_block:BEGIN
    DECLARE v_Transaction_ID INT;
	DECLARE v_Installment_ID INT;
    DECLARE v_isPaid INT DEFAULT 0;

    START TRANSACTION;
    
	SELECT Installment_ID INTO v_Installment_ID
    FROM LoanInstallments
    WHERE Installment_ID = p_Installment_ID;
    
    IF v_Installment_ID IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Installment doesnt exist.';
        ROLLBACK;
		LEAVE proc_block;
    END IF;

    SELECT Transaction_ID INTO v_isPaid
    FROM LoanInstallments
    WHERE Installment_ID = p_Installment_ID;

    IF v_isPaid IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Installment already paid.';
        ROLLBACK;
		LEAVE proc_block;
    END IF;

    INSERT INTO Transaction (FromAccount, ToAccount, Date, Value, Type)
    VALUES (p_Account_ID, 1, NOW(), p_Amount, 'Loan Payment');

    SET v_Transaction_ID = LAST_INSERT_ID();
    IF v_Transaction_ID IS NULL THEN
        ROLLBACK;
		LEAVE proc_block;
    END IF;

    UPDATE LoanInstallments
    SET Transaction_ID = v_Transaction_ID
    WHERE Installment_ID = p_Installment_ID;

    IF ROW_COUNT() = 0 THEN
        ROLLBACK;
		LEAVE proc_block;
    END IF;

    COMMIT;
END$$

DELIMITER ;
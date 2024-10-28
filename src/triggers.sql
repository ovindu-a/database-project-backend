-- transaction trigger

DELIMITER $$

-- BEFORE INSERT trigger to check transaction count
CREATE TRIGGER CheckTransactionCountBeforeInsert
BEFORE INSERT ON Transaction
FOR EACH ROW
BEGIN
    DECLARE transactionCount INT;

    -- Count the number of transactions for the current month
    SELECT COUNT(*)
    INTO transactionCount
    FROM Transaction
    WHERE FromAccount = NEW.FromAccount
      AND MONTH(Date) = MONTH(CURRENT_DATE())
      AND YEAR(Date) = YEAR(CURRENT_DATE());


    -- Raise an error if the transaction count exceeds 5
    IF transactionCount >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction limit for the current month exceeded';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER UpdateAccountBalancesAfterTransaction
AFTER INSERT ON Transaction
FOR EACH ROW
BEGIN
    -- Update the balance of the from account (debit the amount)
    IF NEW.FromAccount IS NOT NULL THEN
        UPDATE Account
        SET Balance = Balance - NEW.Value
        WHERE Account_ID = NEW.FromAccount;
    END IF;

    -- Update the balance of the to account (credit the amount)
    IF NEW.ToAccount IS NOT NULL THEN
        UPDATE Account
        SET Balance = Balance + NEW.Value
        WHERE Account_ID = NEW.ToAccount;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER CreateLoanInstallmentsAfterInsert
AFTER INSERT ON Loan
FOR EACH ROW
BEGIN
    DECLARE monthlyInterestRate DECIMAL(10, 5);
    DECLARE numberOfPayments INT;
    DECLARE monthlyInstallment DECIMAL(15, 2);
    DECLARE i INT DEFAULT 1;
    DECLARE dueDate DATE;

    -- Calculate monthly interest rate
    SET monthlyInterestRate = NEW.InterestRate / 1200;

    -- Calculate number of payments (months)
    SET numberOfPayments = NEW.LoanPeriod;

    -- Calculate monthly installment using the amortizing loan formula
    SET monthlyInstallment = (NEW.LoanValue * (monthlyInterestRate)) / (1 - POW(1 + monthlyInterestRate, -numberOfPayments));

    -- Loop through the number of payments to create each installment
    WHILE i <= numberOfPayments DO
        -- Calculate the due date for each installment
        SET dueDate = DATE_ADD(NEW.Date, INTERVAL i MONTH);

        -- Insert the installment record into the LoanInstallments table
        INSERT INTO LoanInstallments (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value)
        VALUES (NEW.Loan_ID, NEW.Branch_ID, NULL, dueDate, ROUND(monthlyInstallment, 2));

        -- Increment loop counter
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

DELIMITER $$

CREATE EVENT ApplyMonthlyInterestEvent
ON SCHEDULE
    EVERY 1 MONTH
    STARTS (LAST_DAY(CURRENT_DATE) + INTERVAL 1 DAY - INTERVAL 1 MONTH)
    ON COMPLETION PRESERVE
DO
BEGIN
    -- Call the procedure on the last day of every month
    CALL ApplyMonthlyInterest();
END$$

DELIMITER ;

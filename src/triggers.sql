-- transaction trigger

DELIMITER $$

CREATE TRIGGER CheckTransactionCountBeforeInsert
BEFORE INSERT ON Transaction
FOR EACH ROW
BEGIN
    DECLARE transactionCount INT;

    SELECT COUNT(*)
    INTO transactionCount
    FROM Transaction
    WHERE FromAccount = NEW.FromAccount
      AND MONTH(Date) = MONTH(CURRENT_DATE())
      AND YEAR(Date) = YEAR(CURRENT_DATE());


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
    IF NEW.FromAccount IS NOT NULL THEN
        UPDATE Account
        SET Balance = Balance - NEW.Value
        WHERE Account_ID = NEW.FromAccount;
    END IF;

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

    SET monthlyInterestRate = NEW.InterestRate / 1200;

    SET numberOfPayments = NEW.LoanPeriod;

    SET monthlyInstallment = (NEW.LoanValue * (monthlyInterestRate)) / (1 - POW(1 + monthlyInterestRate, -numberOfPayments));

    WHILE i <= numberOfPayments DO
        SET dueDate = DATE_ADD(NEW.Date, INTERVAL i MONTH);

        INSERT INTO LoanInstallments (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value)
        VALUES (NEW.Loan_ID, NEW.Branch_ID, NULL, dueDate, ROUND(monthlyInstallment, 2));

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
    CALL ApplyMonthlyInterest();
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER EnforceSavingsAccountBalanceOnInsert
BEFORE INSERT ON Account
FOR EACH ROW
BEGIN
    IF NEW.Type = 'Savings' THEN
        CASE NEW.Plan
            WHEN 'Children' THEN
                IF NEW.Balance < 0 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Balance cannot be negative for Children plan';
                END IF;

            WHEN 'Teen' THEN
                -- Teen: minimum balance of 500
                IF NEW.Balance < 500 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Teen plan requires a minimum balance of 500';
                END IF;

            WHEN 'Adult' THEN
                -- Adult: minimum balance of 1000
                IF NEW.Balance < 1000 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Adult plan requires a minimum balance of 1000';
                END IF;

            WHEN 'Senior' THEN
                -- Senior: minimum balance of 1000
                IF NEW.Balance < 1000 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Senior plan requires a minimum balance of 1000';
                END IF;

            ELSE
                -- If Plan is invalid, set minimum balance to 0
                IF NEW.Balance < 0 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Balance cannot be negative';
                END IF;
        END CASE;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER EnforceSavingsAccountBalanceOnUpdate
BEFORE UPDATE ON Account
FOR EACH ROW
BEGIN
    IF NEW.Type = 'Savings' THEN
        CASE NEW.Plan
            WHEN 'Children' THEN
                IF NEW.Balance < 0 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Balance cannot be negative for Children plan';
                END IF;

            WHEN 'Teen' THEN
                -- Teen: minimum balance of 500
                IF NEW.Balance < 500 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Teen plan requires a minimum balance of 500';
                END IF;

            WHEN 'Adult' THEN
                -- Adult: minimum balance of 1000
                IF NEW.Balance < 1000 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Adult plan requires a minimum balance of 1000';
                END IF;

            WHEN 'Senior' THEN
                -- Senior: minimum balance of 1000
                IF NEW.Balance < 1000 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Senior plan requires a minimum balance of 1000';
                END IF;

            ELSE
                IF NEW.Balance < 0 THEN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Balance cannot be negative';
                END IF;
        END CASE;
    END IF;
END$$

DELIMITER ;

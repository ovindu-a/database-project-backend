DELIMITER $$

CREATE FUNCTION GetTotalLoanValueByFD(p_FD_ID INT) 
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE totalLoanValue DECIMAL(15, 2);

    -- Calculate the total loan value
    SELECT SUM(l.LoanValue) INTO totalLoanValue
    FROM Loan l
    JOIN LoanApplication la ON l.Application_ID = la.Application_ID
    JOIN Online_loan_to_FD olf ON la.Application_ID = olf.Application_ID
    WHERE olf.FD_ID = p_FD_ID AND la.LoanType = 'Online';

    -- Return the total loan value, or 0 if no loans are found
    RETURN IFNULL(totalLoanValue, 0);
END$$

DELIMITER ;



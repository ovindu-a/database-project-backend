# **Bank Transaction and Loan Processing System**

A core banking solution designed for a private bank in Seychelles, featuring branch management, internal fund transfers, loan processing, and customer account management.

This is the backend for our project for CS3043 - Database systems. 

## **Table of Contents**

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Installation](#installation)
5. [Database Structure](#database-structure)
6. [Project Structure](#project-structure-of-backend)
7. [API Endpoints](#api-endpoints)
   

## **Project Overview**

This project is a core banking solution developed as a proof of concept (PoC) for a small, private bank. The system is designed to handle key banking functionalities such as customer account management, internal fund transfers, and loan processing. 

The system will support:
- Multiple branches, including a head office.
- Different account types (savings, checking, fixed deposits).
- Loan applications and processing for personal and business loans.
- Basic report generation for branch managers.

## **Features**

- **Branch Management**: Manage bank branches, including employees and customers.
- **Account Management**: Create and manage savings and checking accounts. Support for different plans based on customer age group.
- **Fund Transfers**: Internal bank transfers between accounts.
- **Fixed Deposits**: Support for creating Fixed Deposit (FD) accounts and calculating monthly interest.
- **Loan Processing**: Apply for loans at branches or via an online portal.
  - Manual loans (branch approval required).
  - Online loans (instant approval based on FD balance).
- **Reporting**: Generate transaction and loan reports per branch for branch managers.

## **Technologies Used**

- **Frontend**: React.js
- **Backend**: Node.js, Express.js
- **Database**: MySQL
- **Others**: Axios (for API requests), Sequelize (ORM for MySQL), JSON Web Token (JWT) for authentication, bcrypt for password hashing.

git clone https://github.com/ovindu-a/database-project-backend.git


## **Installation**  

### **Prerequisites** 

- **Node.js** (version >= 14) : 
  - First Install NodeJs if you haven't.( https://nodejs.org/dist/v20.16.0/node-v20.16.0-x64.msi)
- **MySQL** (version >= 8)
- **Git** (for cloning the repository)

### **Setup Steps**
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/banking-system.git
   cd banking-system
   ```
2. **Install dependencies**
- After cloning repositary, open a terminal and navigate to folder and run "npm install" to install node modules automatically.

   ```bash
   npm install
   ```
3. **Database Setup**
- Create a new MySQL database.
-	Update the .env file with your database credentials:
   ```
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=banking_system
```

4. **To run in dev mode**

```
npm run dev
```

## **Database Structure**

### **Tables**

- Branch: Stores information about branches, including the head office.

- Manager: Contains details about branch managers.
  
- Employee: Information about employees working at each branch.

- Customer: Stores customer information, both individual and business.

  - Business Customer: Specific details for business customers.

  - Individual Customer: Specific details for individual customers.

- Account: Information on savings and checking accounts for both individuals and businesses.

- Transaction: Records internal transactions between accounts.

- Fixed Deposit: Details of fixed deposits linked to savings accounts.

- Loan: Details about loans taken by customers.

- Loan Application: Information about loan applications.

- Loan Installment: Manages loan repayment installments.

- Online Loan to FD: Information about online loans linked to fixed deposits.


## **ER Diragram**

[ER Diagram.pdf](https://github.com/user-attachments/files/17530929/Group8.ER.Diagram.pdf)

<img width="1030" alt="Screenshot 2024-10-26 at 19 57 20" src="https://github.com/user-attachments/assets/cb22f864-0811-47ea-b59b-d9fddd1aad21" align ="centre">

## **Project Structure of backend**
```
banking-system/
├── controllers/     # Contains route handler functions (business logic)
├── models/          # Database models (e.g., Account, Customer, Loan)
├── routes/          # Route definitions for API endpoints
├── config/          # Configuration files (database, server)
├── middlewares/     # Custom middleware (e.g., authentication)
├── utils/           # Helper functions and utilities
├── public/          # Static files (if any)
├── views/           # Frontend templates (if using server-side rendering)
├── .env             # Environment variables
├── app.js           # Main server setup file
└── README.md        # Project documentation
```

## **API Endpoints** 

### API Endpoints for Bank Account Management
 
### 1. `getAllAccounts`
- **Endpoint**: GET `https://ourbankURL/api/accounts`
- **Description**: Fetches and returns all accounts from the database.
- **Response**:
  - Returns a JSON array of all accounts.
  - Sends a `500` status response with an error message if an error occurs.

### 2. `createAccount`
- **Endpoint**: POST `https://ourbankURL/api/accounts`
- **Description**: Creates a new bank account using data from the request body.
- **Features**:
  - If the account type is 'Savings', it generates monthly interest transactions based on the provided plan.
- **Request Body**:
  - `Branch_ID`: The ID of the branch.
  - `Customer_ID`: The ID of the customer.
  - `Type`: The type of account (e.g., Savings).
  - `Balance`: The initial balance for the account.
  - `OpeningDate`: The date when the account is opened.
  - `Plan`: The plan associated with the account (if applicable).
- **Response**:
  - Returns the details of the newly created account upon success.
  - Sends an error message if the account creation fails.

### 3. `getAccountById`
- **Endpoint**: GET `https://ourbankURL/api/accounts/customer/:customer`
- **Description**: Retrieves a specific account by its ID.
- **Response**:
  - Returns the account details if found.
  - Sends a `404` status with a 'not found' message if the account does not exist.

### 4. `getByCustomer`
- **Endpoint**: GET `https://ourbankURL/api/accounts/:id`
- **Description**: Fetches all accounts associated with a specific customer ID.
- **Response**:
  - Returns the accounts related to the specified customer.
  - Sends an error message if an issue occurs during the retrieval process.

### 5. `withdrawFromAccount`
- **Endpoint**: POST `https://ourbankURL/api/accounts/withdraw/:accountId`
- **Description**: Handles the withdrawal process from a specified account.
- **Request Body**:
  - `amount`: The amount to withdraw.
- **Features**:
  - Checks the account balance before allowing the withdrawal.
  - Creates a transaction record for the withdrawal (assumed to be an ATM withdrawal).
- **Response**:
  - Returns a success message upon successful withdrawal.
  - Sends appropriate error messages for insufficient funds or account issues.


### API Endpoints for Branch Management

### 1. `getAllBranches`
- **Endpoint**: GET `https://ourbankURL/api/branches/`
- **Description**: Fetches and returns all branches from the database.
- **Response**:
  - Returns a JSON array of all branches.
  - Sends a `500` status response with an error message if an error occurs.

### 2. `createBranch`
- **Endpoint**: POST `https://ourbankURL/api/branches/`
- **Description**: Creates a new branch using data from the request body.
- **Request Body**:
  - `Name`: The name of the branch.
  - `Address`: The address of the branch.
  - `Manager_ID`: The ID of the manager associated with the branch.
- **Validation**:
  - Checks if the specified manager exists. If not, it returns a `400` status with an error message.
- **Response**:
  - Returns the details of the newly created branch upon success.
  - Sends an error message if the branch creation fails.

### 3. `getBranchById`
- **Endpoint**: GET `https://ourbankURL/api/branches/:id`
- **Description**: Retrieves a specific branch by its ID.
- **Response**:
  - Returns the branch details if found.
  - Sends a `404` status with a 'Branch not found' message if the branch does not exist.

### 4. `updateBranch`
- **Endpoint**: PUT `https://ourbankURL/api/branches/:id`
- **Description**: Updates the details of a specific branch.
- **Request Body**:
  - Contains the updates for the branch (e.g., name, address, manager ID).
- **Response**:
  - Returns a success message upon successful update.
  - Sends a `404` status with a 'Branch not found' message if the branch does not exist.

### 5. `deleteBranch`
- **Endpoint**:  `https://ourbankURL/api/branches/:id`
- **Description**: Deletes a specific branch by its ID.
- **Response**:
  - Returns a success message upon successful deletion.
  - Sends a `404` status with a 'Branch not found' message if the branch does not exist.
 

### API Endpoints for Manager Management
 
### 1. `getAllManagers`
- **Endpoint**: GET `https://ourbankURL/api/managers/`
- **Description**: Fetches and returns all managers from the database.
- **Response**:
  - Returns a JSON array of all managers.
  - Sends a `500` status response with an error message if an error occurs.

### 2. `createManager`
- **Endpoint**: POST `https://ourbankURL/api/managers/`
- **Description**: Creates a new manager using data from the request body.
- **Request Body**:
  - `name`: The name of the manager.
  - `username`: The username for login.
  - `password`: The password for login (hashed before storing).
- **Response**:
  - Returns details of the newly created manager upon success.
  - Sends an error message if manager creation fails.

### 3. `getManagerById`
- **Endpoint**: GET `https://ourbankURL/api/managers/:id`
- **Description**: Retrieves a specific manager by their ID.
- **Response**:
  - Returns manager details if found.
  - Sends a `404` status with a 'Manager not found' message if the manager does not exist.

### 4. `updateManagerBranchId`
- **Endpoint**: PUT `https://ourbankURL/api/managers/:id`
- **Description**: Updates the branch ID associated with a specific manager.
- **Request Body**:
  - `Branch_ID`: The new branch ID to be associated with the manager.
- **Response**:
  - Returns a success message upon successful update.
  - Sends a `404` status if the manager is not found.

### 5. `deleteManager`
- **Endpoint**: DELETE `https://ourbankURL/api/managers/:id`
- **Description**: Deletes a specific manager by their ID.
- **Response**:
  - Returns a success message upon successful deletion.
  - Sends a `404` status with a 'Manager not found' message if the manager does not exist.

### 6. `loginManager`
- **Endpoint**: POST `https://ourbankURL/api/managers/login`
- **Description**: Authenticates a manager using username and password.
- **Request Body**:
  - `username`: The username for login.
  - `password`: The password for login.
- **Features**:
  - Compares the provided password with the stored hashed password.
  - Generates an OTP and sends it to the manager's email for two-factor authentication.
- **Response**:
  - Returns a success message and the manager's ID upon successful authentication.

### 7. `verifyOtp`
- **Endpoint**: POST `https://ourbankURL/api/managers//verify-otp`
- **Description**: Verifies the OTP sent to the manager's email during login.
- **Request Body**:
  - `Manager_ID`: The ID of the manager.
  - `otp`: The OTP provided by the manager.
- **Response**:
  - Returns a success message and logs the manager in upon successful OTP verification.
  - Sends a `401` status with an 'Invalid OTP' message if the OTP does not match.
 

### API Endpoints for Customer Management

### 1. `getAllCustomers`
- **Endpoint**: GET `https://ourbankURL/api/customers/`
- **Description**: Fetches all customers from the database.
- **Response**:
  - Returns a JSON array of all customers.
  - Sends a `500` status response with an error message if an error occurs.

### 2. `createCustomer`
- **Endpoint**: POST `https://ourbankURL/api/customers/`
- **Description**: Creates a new customer with the given details.
- **Request Body**:
  - `Name`: The customer's name.
  - `NIC`: The customer's national ID number.
  - `Address`: The customer's address.
  - `username`: Username for customer login.
  - `password`: Password for customer login (hashed before storing).
- **Response**:
  - Returns the details of the newly created customer.
  - Sends an error message if the creation fails.

### 3. `getCustomerById`
- **Endpoint**: GET `https://ourbankURL/api/customers/:id`
- **Description**: Retrieves a specific customer by their ID.
- **Response**:
  - Returns the customer details if found.
  - Sends a `404` status with a 'Customer not found' message if the customer does not exist.

### 4. `updateCustomer`
- **Endpoint**: PUT `https://ourbankURL/api/customers/:id`
- **Description**: Updates a customer's information.
- **Request Params**:
  - `id`: Customer ID to update.
- **Request Body**:
  - JSON object containing fields to update.
- **Response**:
  - Returns a success message upon successful update.
  - Sends a `404` status if the customer is not found.

### 5. `deleteCustomer`
- **Endpoint**: DELETE `https://ourbankURL/api/customers/:id`
- **Description**: Deletes a customer by their ID.
- **Response**:
  - Returns a success message upon successful deletion.
  - Sends a `404` status with a 'Customer not found' message if the customer does not exist.

### 6. `loginCustomer`
- **Endpoint**: POST `https://ourbankURL/api/customers/login`
- **Description**: Authenticates a customer using username and password.
- **Request Body**:
  - `username`: Customer’s username.
  - `password`: Customer’s password.
- **Features**:
  - Validates the password against the stored hashed password.
  - Generates an OTP and sends it to the customer’s registered email.
- **Response**:
  - Returns a message indicating OTP sent and Customer ID upon successful authentication.
  - Sends an error message for invalid username/password.

### 7. `verifyOtp`
- **Endpoint**: POST `https://ourbankURL/api/customers/verify-otp`
- **Description**: Verifies the OTP sent to the customer during login.
- **Request Body**:
  - `Customer_ID`: Customer's ID.
  - `otp`: The OTP received by the customer.
- **Response**:
  - Generates a JWT token and sets it as an HTTP-only cookie upon successful OTP verification.
  - Sends a `401` status with an 'Invalid OTP' message if the OTP does not match.

### 8. `getCustomerByLoanId`
- **Endpoint**: GET `https://ourbankURL/api/customers/by-loan/:id`
- **Description**: Retrieves customer details along with associated loan information based on a given loan ID.
- **Request Params**:
  - `id`: Loan ID.
- **Response**:
  - Returns a JSON object with combined customer and loan information if both exist.
  - Sends a `404` status if the customer or loan is not found.

### 9. `getBriefInfoByCustomerId`
- **Endpoint**: GET `https://ourbankURL/api/customers/brief-info/:id`
- **Description**: Retrieves brief information for a customer, including accounts, loans, and fixed deposits.
- **Request Params**:
  - `id`: Customer ID.
- **Response**:
  - Returns a JSON object containing brief customer information, including:
    - `user`: Customer details.
    - `accounts`: Account details.
    - `loans`: Loan details.
    - `fds`: Fixed deposit details (only ID and initial amount).



### API Endpoints for Employee Management
These are the API endpoints for managing employee records, including authentication with OTP and JWT for security.

### 1. Get All Employees
- **Endpoint**: GET `https://ourbankURL/api/employees/`
- **Description**: Retrieves a list of all employee records from the database.
#### Response:
- **Success** (`200`): JSON array containing all employee records.
- **Error** (`500`): JSON object with error message.

### 2. Create a New Employee
- **Endpoint**: POST `https://ourbankURL/api/employees/`
- **Description**: Creates a new employee record with details provided in the request body.
#### Request Body:
- `Branch_ID`: ID of the branch where the employee works.
- `name`: Name of the employee.
- `username`: Username for the employee login.
- `password`: Plaintext password to be hashed for security.
#### Response:
- **Success** (`201`): JSON object with details of the newly created employee.
- **Error** (`500`): JSON object with error message.

### 3. Get Employee by ID
- **Endpoint**: GET `https://ourbankURL/api/employees/:id`
- **Description**: Retrieves a specific employee record by its ID.
#### Path Parameter:
  - `id` (required): The unique ID of the employee.
#### Response:
- **Success** (`200`): JSON object containing the employee details.
- **Not Found** (`404`): JSON message indicating "Employee not found."
- **Error** (`500`): JSON object with error message.

### 4. Update Employee by ID
- **Endpoint**: PUT `https://ourbankURL/api/employees/:id`
- **Description**: Updates an existing employee record by its ID with details provided in the request body.
#### Path Parameter:
  - `id` (required): The unique ID of the employee to update.
#### Request Body:
- JSON object containing the fields to update.
#### Response:
- **Success** (`200`): JSON message indicating "Employee updated successfully."
- **Not Found** (`404`): JSON message indicating "Employee not found."
- **Error** (`500`): JSON object with error message.

### 5. Delete Employee by ID
- **Endpoint**: DELETE `https://ourbankURL/api/employees/:id`
- **Description**: Deletes a specific employee record by its ID.
#### Path Parameter:
  - `id` (required): The unique ID of the employee to delete.
#### Response:
- **Success** (`200`): JSON message indicating "Employee deleted successfully."
- **Not Found** (`404`): JSON message indicating "Employee not found."
- **Error** (`500`): JSON object with error message.

### 6. Login Employee
- **Endpoint**: POST `https://ourbankURL/api/employees/login`
- **Description**: Authenticates an employee by verifying their username and password, and sends an OTP to their email if credentials are correct.
#### Request Body:
- `username`: Username of the employee.
- `password`: Plaintext password for verification.
#### Response:
- **Success** (`200`): JSON message indicating "Login successful, OTP sent to your email" along with the `Employee_ID`.
- **Not Found** (`404`): JSON message indicating "Employee not found."
- **Unauthorized** (`401`): JSON message indicating "Invalid username or password."
- **Error** (`500`): JSON object with error message.

### 7. Verify OTP
- **Endpoint**: POST `https://ourbankURL/api/employees/verify-otp`
- **Description**: Verifies the OTP sent to the employee’s email and, if valid, issues a JWT token to log the user in.
#### Request Body:
- `Employee_ID`: The unique ID of the employee.
- `otp`: OTP sent to the employee's email.
#### Response:
- **Success** (`200`): JSON message indicating "OTP verified successfully, you are logged in," with the `Employee_ID`. A JWT token is also set as a cookie.
- **Unauthorized** (`401`): JSON message indicating "Invalid OTP."
- **Error** (`500`): JSON object with error message.



### API Endpoints for FD Management
Here are the endpoints available for managing Fixed Deposit (FD) records in the system.

### 1. Get All FDs
- **Endpoint**: GET `https://ourbankURL/api/fixedDeposits/`
- **Description**: This api retrives a list of all Fixed Deposit records in the database.
- #### Response:
  - **Success** (`200`): JSON array containing all FD records.
  - **Error** (`500`): JSON object with error message.

### 2. Create a New FD
- **Endpoint**: POST `https://ourbankURL/api/fixedDeposits/`
- **Description**:This api creates a new Fixed Deposit (FD) record.
- #### Request:
  **Request Body** (JSON):
  - `Branch_ID` (required): ID of the branch where the FD is created.
  - `Account_ID` (required): ID of the account associated with the FD.
  - `Period` (required): Duration of the FD.
  - `StartDate` (required): Start date of the FD.
  - `InitialAmount` (required): Initial deposit amount.
- #### Response:
  - **Success** (`201`): JSON object with details of the newly created FD record.
  - **Error** (`500`): JSON object with error message.

### 3. Get FD by ID
- **Endpoint**: GET `https://ourbankURL/api/fixedDeposits/:id`
- **Description**: This API retrieves a specific FD record by its ID.
- #### Path Parameter:
  - `id` (required): The unique ID of the FD.
- #### Response:
  - **Success** (`200`): JSON object containing the FD details.
  - **Not Found** (`404`): JSON message indicating "FD not found."
  - **Error** (`500`): JSON object with error message.

### 4. Delete FD by ID
- **Endpoint**: DELETE `https://ourbankURL/api/fixedDeposits/:id`
- **Description**: This API deletes a FD record by its ID.
- #### Path Parameter:
  - `id` (required): The unique ID of the FD to delete.
- #### Response:
   - **Success** (`200`): JSON message indicating "FD deleted successfully."
   - **Not Found** (`404`): JSON message indicating "FD not found."
   - **Error** (`500`): JSON object with error message.

### 5. Get FDs by Customer ID
- **Endpoint**: GET `https://ourbankURL/api/fixedDeposits/customer/:customerId`
- **Description**: This API retrieves all FD records associated with a specific customer.
- #### Path Parameter:
  - `customerId` (required): The unique ID of the customer.
- #### Response:
   - **Success** (`200`): JSON array containing FD records associated with the customer.
   - **Not Found** (`404`): JSON message indicating "No Fixed Deposits found for this customer."
   - **Error** (`500`): JSON object with error message.

 ### API Endpoints for Loan Management

These are the API endpoints for managing loan records in our system.

### 1. Get All Loans
- **Endpoint**: GET `https://ourbankURL/api/loans/`
- **Description**: Retrieves a list of all loan records from the database.
#### Response:
- **Success** (`200`): JSON array containing all loan records.
- **Error** (`500`): JSON object with error message.

### 2. Create a New Loan
- **Endpoint**: POST `https://ourbankURL/api/loans/`
- **Description**: Creates a new loan record with details provided in the request body.
#### Request Body:
- `Branch_ID`: ID of the branch where the loan is created.
- `Customer_ID`: ID of the customer taking the loan.
- `LoanPeriod`: Duration of the loan.
- `InterestRate`: Interest rate for the loan.
- `Date`: Start date of the loan.
- `LoanValue`: Value of the loan.
- `Application_ID`: ID of the loan application.
#### Response:
- **Success** (`201`): JSON object with details of the newly created loan.
- **Error** (`500`): JSON object with error message.

### 3. Get Loan by ID
- **Endpoint**: GET `https://ourbankURL/api/loans/:id`
- **Description**: Retrieves a specific loan record by its ID.
#### Path Parameter:
  - `id` (required): The unique ID of the loan.
#### Response:
- **Success** (`200`): JSON object containing the loan details.
- **Not Found** (`404`): JSON message indicating "Loan not found."
- **Error** (`500`): JSON object with error message.

### 4. Update Loan by ID
- **Endpoint**: PUT `https://ourbankURL/api/loans/:id`
- **Description**: Updates an existing loan record by its ID with details provided in the request body.
#### Path Parameter:
  - `id` (required): The unique ID of the loan to update.
#### Request Body:
- JSON object containing the fields to update
#### Response:
- **Success** (`200`): JSON message indicating "Loan updated successfully."
- **Not Found** (`404`): JSON message indicating "Loan not found."
- **Error** (`500`): JSON object with error message.

### 5. Delete Loan by ID
- **Endpoint**: DELETE `https://ourbankURL/api/loans/:id`
- **Description**: Deletes a loan record by its ID.
#### Path Parameter:
  - `id` (required): The unique ID of the loan to delete.
#### Response:
- **Success** (`200`): JSON message indicating "Loan deleted successfully."
- **Not Found** (`404`): JSON message indicating "Loan not found."
- **Error** (`500`): JSON object with error message.

### 6. Get Loans by Customer ID
- **Endpoint**: GET `https://ourbankURL/api/loans/customer/:id`
- **Description**: Retrieves all loan records associated with a specific customer by their Customer ID.
#### Path Parameter:
  - `customerId` (required): The unique ID of the customer.
#### Response:
- **Success** (`200`): JSON array containing loan records associated with the customer.
- **Not Found** (`404`): JSON message indicating "No loans found for this customer."
- **Error** (`500`): JSON object with error message.

### 7. Create a Quick Loan
- **Endpoint**: POST `https://ourbankURL/api/loans/quick-loan`
- **Description**: Creates a quick loan record associated with an existing Fixed Deposit.
#### Request Body:
- `Branch_ID` (required): ID of the branch where the loan is created.
- `Customer_ID` (required): ID of the customer taking the loan.
- `LoanPeriod` (required): Duration of the loan.
- `InterestRate` (required): Interest rate for the loan.
- `Date` (required): Start date of the loan.
- `LoanValue` (required): Value of the loan.
- `FD_ID` (required): ID of the related Fixed Deposit.
#### Response:
- **Success** (`201`): JSON object with details of the newly created quick loan.
- **Error** (`500`): JSON object with error message.



### API Endpoints for Transaction Management

These are descriptions of each API endpoint for managing transaction records.

### 1. Get All Transactions
- **Endpoint**: GET `https://ourbankURL/api/transactions/`
- **Description**: Retrieves a list of all transaction records from the database.

#### Response:
- **Success** (`200`): JSON array containing all transaction records.
- **Error** (`500`): JSON object with error message.

### 2. Create a New Transaction
- **Endpoint**: POST `https://ourbankURL/api/transactions/`
- **Description**: Creates a new transaction record with details provided in the request body.

#### Request Body:
- `FromAccount` (required): ID of the account sending the transaction.
- `ToAccount` (required): ID of the account receiving the transaction.
- `Date` (required): Date of the transaction.
- `Value` (required): Amount of the transaction.
- `Type` (required): Type of transaction 

#### Response:
- **Success** (`201`): JSON object with details of the newly created transaction.
- **Error** (`500`): JSON object with error message.

### 3. Get Transaction by ID
- **Endpoint**: GET `https://ourbankURL/api/transactions/:id`
- **Description**: Retrieves a specific transaction record by its ID.

#### Path Parameter:
  - `id` (required): The unique ID of the transaction.

#### Response:
- **Success** (`200`): JSON object containing the transaction details.
- **Not Found** (`404`): JSON message indicating "Transaction not found."
- **Error** (`500`): JSON object with error message.

### 4. Update Transaction by ID
- **Endpoint**: PUT `https://ourbankURL/api/transactions/:id`
- **Description**: Updates an existing transaction record by its ID with details provided in the request body.

#### Path Parameter:
  - `id` (required): The unique ID of the transaction to update.

#### Request Body:
- JSON object containing the fields to update 

#### Response:
- **Success** (`200`): JSON message indicating "Transaction updated successfully."
- **Not Found** (`404`): JSON message indicating "Transaction not found."
- **Error** (`500`): JSON object with error message.

### 5. Delete Transaction by ID
- **Endpoint**: DELETE `https://ourbankURL/api/transactions/:id`
- **Description**: Deletes a transaction record by its ID.

#### Path Parameter:
  - `id` (required): The unique ID of the transaction to delete.

#### Response:
- **Success** (`200`): JSON message indicating "Transaction deleted successfully."
- **Not Found** (`404`): JSON message indicating "Transaction not found."
- **Error** (`500`): JSON object with error message.

### 6. Get Transactions by Sent Account
- **Endpoint**: GET `https://ourbankURL/api/transactions/fromAccount/:account`
- **Description**: Retrieves all transactions sent from a specified account.

#### Path Parameter:
  - `account` (required): The unique ID of the sending account.

#### Response:
- **Success** (`200`): JSON array containing transactions sent from the specified account.
- **Error** (`500`): JSON object with error message.

### 7. Get Transactions by Received Account
- **Endpoint**: GET `https://ourbankURL/api/transactions/toAccount/:account`
- **Description**: Retrieves all transactions received by a specified account.

#### Path Parameter:
  - `account` (required): The unique ID of the receiving account.

#### Response:
- **Success** (`200`): JSON array containing transactions received by the specified account.
- **Error** (`500`): JSON object with error message.

### 8. Get All Transactions by Account
- **Endpoint**: GET `https://ourbankURL/api/transactions/byAccount/:account`
- **Description**: Retrieves all transactions related to a specified account, including both sent and received transactions.

#### Path Parameter:
  - `account` (required): The unique ID of the account.

#### Response:
- **Success** (`200`): JSON array containing all transactions associated with the account.
- **Error** (`500`): JSON object with error message.

### 9. Get Outgoing Report for Manager
- **Endpoint**: POST `https://ourbankURL/api/transactions/outgoingReport/:id`
- **Description**: Retrieves a report of all outgoing transactions within a specified date range for a manager's branch.

#### Path Parameter:
  - `id` (required): The unique ID of the manager.

#### Request Body:
- `startDate` (required): Start date of the report period.
- `endDate` (required): End date of the report period.

#### Response:
- **Success** (`200`): JSON array of outgoing transactions within the date range.
- **Error** (`500`): JSON object with error message.

### 10. Get Incoming Report for Manager
- **Endpoint**: POST `https://ourbankURL/api/transactions/incomingReport/:id`
- **Description**: Retrieves a report of all incoming transactions within a specified date range for a manager's branch.

#### Path Parameter:
  - `id` (required): The unique ID of the manager.

#### Request Body:
- `startDate` (required): Start date of the report period.
- `endDate` (required): End date of the report period.

#### Response:
- **Success** (`200`): JSON array of incoming transactions within the date range.
- **Error** (`500`): JSON object with error message.

### 11. Get Transaction Totals for Manager
- **Endpoint**: GET `https://ourbankURL/api/transactions/transaction-totals/:managerId`
- **Description**: Retrieves the total amount of all transactions managed by a specific branch manager.

#### Path Parameter:
  - `managerId` (required): The unique ID of the manager.

#### Response:
- **Success** (`200`): JSON object containing the total transaction value.
- **Error** (`500`): JSON object with error message.

### API Endpoints for Loan Application Management

### 1. Get All Loan Applications
- **Endpoint**: GET `https://ourbankURL/api/loanApplications/`
- **Description**: Retrieves a list of all loan applications.

#### Response:
- **Success** (`200`): JSON array containing all loan application records.
- **Error** (`500`): JSON object with error message.

### 2. Create a New Loan Application
- **Endpoint**: POST `https://ourbankURL/api/loanApplications/`
- **Description**: Creates a new loan application with the details provided in the request body.

#### Request Body:
- `Branch_ID` (required): ID of the branch associated with the application.
- `Customer_ID` (required): ID of the customer applying for the loan.
- `LoanPeriod` (required): Duration of the loan period.
- `Date` (required): Application date.
- `LoanValue` (required): Amount requested for the loan.
- `Approved` (required): Approval status of the application.
- `LoanType` (required): Type of loan being applied for.

#### Response:
- **Success** (`201`): JSON object with details of the newly created loan application.
- **Error** (`500`): JSON object with error message.

### 3. Get Loan Application by ID
- **Endpoint**: GET `https://ourbankURL/api/loanApplications/:id`
- **Description**: Retrieves a specific loan application by its ID.

#### Path Parameter:
  - `id` (required): Unique ID of the loan application.

#### Response:
- **Success** (`200`): JSON object containing the loan application details.
- **Not Found** (`404`): JSON message indicating "Loan application not found."
- **Error** (`500`): JSON object with error message.

### 4. Update Loan Application by ID
- **Endpoint**: PUT `https://ourbankURL/api/loanApplications/:id`
- **Description**: Updates an existing loan application by its ID.

#### Path Parameter:
  - `id` (required): Unique ID of the loan application to update.

#### Request Body:
- JSON object with the fields to update.

#### Response:
- **Success** (`200`): JSON message indicating "Loan application updated successfully."
- **Not Found** (`404`): JSON message indicating "Loan application not found."
- **Error** (`500`): JSON object with error message.

### 5. Delete Loan Application by ID
- **Endpoint**: DELETE `https://ourbankURL/api/loanApplications/:id`
- **Description**: Deletes a loan application by its ID.

#### Path Parameter:
  - `id` (required): Unique ID of the loan application to delete.

#### Response:
- **Success** (`200`): JSON message indicating "Loan application deleted successfully."
- **Not Found** (`404`): JSON message indicating "Loan application not found."
- **Error** (`500`): JSON object with error message.

### 6. Get Loan Applications by Manager ID
- **Endpoint**: GET `https://ourbankURL/api/loanApplications/manager/:id`
- **Description**: Retrieves all loan applications associated with a specific manager's branch.

#### Path Parameter:
  - `id` (required): Unique ID of the manager.

#### Response:
- **Success** (`200`): JSON array containing loan applications for the manager's branch.
- **Error** (`500`): JSON object with error message.

### 7. Get Pending Loan Applications by Customer ID
- **Endpoint**: GET `https://ourbankURL/api/loanApplications/pending/:customerId`
- **Description**: Retrieves all pending loan applications for a specific customer.

#### Path Parameter:
  - `customerId` (required): Unique ID of the customer.

#### Response:
- **Success** (`200`): JSON array containing pending loan applications for the specified customer.
- **Error** (`500`): JSON object with error message.

### 8. Approve Loan Application
- **Endpoint**: POST `https://ourbankURL/api/loanApplications/approve/:id`
- **Description**: Approves a loan application by its ID and, if approved, creates a new loan record.

#### Path Parameter:
  - `id` (required): Unique ID of the loan application to approve.

#### Request Body:
- `Manager_ID` (required): ID of the manager approving the loan.
- `Approved` (required): Approval status 

#### Response:
- **Success** (`201`): JSON message indicating "Loan application approved successfully and loan created."
- **Not Authorized** (`403`): JSON message indicating "Manager is not authorized to approve this loan application."
- **Not Found** (`404`): JSON message indicating "Loan application not found."
- **Error** (`500`): JSON object with error message.



### API Endpoints for Loan Installment Management
These are the API endpoints for managing loan installment records in our banking system.

### 1. Get All Loan Installments
- **Endpoint**: GET `https://ourbankURL/api/loanInstallments/`
- **Description**: Retrieves a list of all loan installment records from the database.
#### Response:
- **Success** (`200`): JSON array containing all loan installment records.
- **Error** (`500`): JSON object with error message.

### 2. Create a New Loan Installment
- **Endpoint**: POST `https://ourbankURL/api/loanInstallments/`
- **Description**: Creates a new loan installment record with details provided in the request body.
#### Request Body:
- `Loan_ID`: ID of the loan associated with the installment.
- `Branch_ID`: ID of the branch handling the installment.
- `Transaction_ID`: ID of the transaction related to the installment.
- `DueDate`: Due date of the installment.
- `Value`: Amount of the installment.
#### Response:
- **Success** (`201`): JSON object with details of the newly created installment.
- **Error** (`500`): JSON object with error message.

### 3. Get Loan Installment by ID
- **Endpoint**: GET `https://ourbankURL/api/loanInstallments/:id`
- **Description**: Retrieves a specific loan installment record by its ID.
#### Path Parameter:
  - `id` (required): The unique ID of the loan installment.
#### Response:
- **Success** (`200`): JSON object containing the loan installment details.
- **Not Found** (`404`): JSON message indicating "Loan Installment not found."
- **Error** (`500`): JSON object with error message.

### 4. Update Loan Installment by ID
- **Endpoint**: PUT `https://ourbankURL/api/loanInstallments/:id`
- **Description**: Updates an existing loan installment record by its ID with details provided in the request body.
#### Path Parameter:
  - `id` (required): The unique ID of the loan installment to update.
#### Request Body:
- JSON object containing the fields to update
#### Response:
- **Success** (`200`): JSON message indicating "Loan Installment updated successfully."
- **Not Found** (`404`): JSON message indicating "Loan Installment not found."
- **Error** (`500`): JSON object with error message.

### 5. Delete Loan Installment by ID
- **Endpoint**: DELETE `https://ourbankURL/api/loanInstallments/:id`
- **Description**: Deletes a specific loan installment record by its ID.
#### Path Parameter:
  - `id` (required): The unique ID of the loan installment to delete.
#### Response:
- **Success** (`200`): JSON message indicating "Loan Installment deleted successfully."
- **Not Found** (`404`): JSON message indicating "Loan Installment not found."
- **Error** (`500`): JSON object with error message.

### 6. Get Loan Installments by Loan ID
- **Endpoint**: GET `https://ourbankURL/api/loanInstallments/loan/:Loan_ID`
- **Description**: Retrieves all loan installments associated with a specific loan ID.
#### Path Parameter:
  - `Loan_ID` (required): The unique ID of the loan for which installments are retrieved.
#### Response:
- **Success** (`200`): JSON array containing loan installments for the specified loan.
- **Not Found** (`404`): JSON message indicating "No loan installments found for this loan."
- **Error** (`500`): JSON object with error message.

### 7. Get Late Loan Installments by Branch ID
- **Endpoint**: GET `https://ourbankURL/api/loanInstallments/late/:id`
- **Description**: Retrieves loan installments that are overdue for a specific branch.
#### Path Parameter:
  - `id` (required): The unique ID of the branch to filter late loan installments.
#### Response:
- **Success** (`200`): JSON array containing late loan installments for the specified branch.
- **Error** (`500`): JSON object with error message.

### 8. Make Installment Payment
- **Endpoint**: POST `https://ourbankURL/api/loanInstallments/pay/:installmentId`
- **Description**: Processes a payment for a specific loan installment.
#### Path Parameter:
  - `installmentId` (required): The unique ID of the installment being paid.
#### Request Body:
- `accountId`: ID of the account making the payment.
- `amount`: Amount being paid toward the installment.
#### Response:
- **Success** (`200`): JSON message indicating "Installment payment made successfully."
- **Not Found** (`404`): JSON message indicating "Installment not found or payment failed."
- **Bad Request** (`400`): JSON message indicating "Installment already paid."
- **Error** (`500`): JSON object with error message.



### API Endpoints for Analysis Management
These are the API endpoints for retrieving analytical data about accounts, customers, and distributions in the banking system.


### 1. Get Account Summary by Branch
- **Endpoint**: GET `https://ourbankURL/api/analysis/branch/:branchId`
- **Description**: Retrieves a summary of accounts for a specified branch.
#### Path Parameter:
  - `branchId` (required): The unique ID of the branch to retrieve account summary.
#### Response:
- **Success** (`200`): JSON object containing the account summary data for the branch.
- **Error** (`500`): JSON object with error message.

### 2. Get Customer Distribution
- **Endpoint**: GET `https://ourbankURL/api/analysis/customer-distribution`
- **Description**: Retrieves the distribution of customers across various segments.
#### Response:
- **Success** (`200`): JSON array containing the customer distribution data.
- **Error** (`500`): JSON object with error message.

### 3. Get Customer Account Summary
- **Endpoint**: GET `https://ourbankURL/api/analysis/customer-account-summary`
- **Description**: Provides a summary of accounts held by each customer.
#### Response:
- **Success** (`200`): JSON array containing the account summary for each customer.
- **Error** (`500`): JSON object with error message.



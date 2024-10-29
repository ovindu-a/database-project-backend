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

### Bank Account Management API

#### Overview of Controller Functions

##### 1. `getAllAccounts`
- **Endpoint**: GET `https://ourbankURL/api/accounts`
- **Description**: Fetches and returns all accounts from the database.
- **Response**:
  - Returns a JSON array of all accounts.
  - Sends a `500` status response with an error message if an error occurs.

##### 2. `createAccount`
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

##### 3. `getAccountById`
- **Endpoint**: GET `https://ourbankURL/api/accounts/customer/:customer`
- **Description**: Retrieves a specific account by its ID.
- **Response**:
  - Returns the account details if found.
  - Sends a `404` status with a 'not found' message if the account does not exist.

##### 4. `getByCustomer`
- **Endpoint**: GET `https://ourbankURL/api/accounts/:id`
- **Description**: Fetches all accounts associated with a specific customer ID.
- **Response**:
  - Returns the accounts related to the specified customer.
  - Sends an error message if an issue occurs during the retrieval process.

##### 5. `withdrawFromAccount`
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



### Branch Management API

#### Overview of Controller Functions

##### 1. `getAllBranches`
- **Endpoint**: GET `https://ourbankURL/api/branches/`
- **Description**: Fetches and returns all branches from the database.
- **Response**:
  - Returns a JSON array of all branches.
  - Sends a `500` status response with an error message if an error occurs.

##### 2. `createBranch`
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

##### 3. `getBranchById`
- **Endpoint**: GET `https://ourbankURL/api/branches/:id`
- **Description**: Retrieves a specific branch by its ID.
- **Response**:
  - Returns the branch details if found.
  - Sends a `404` status with a 'Branch not found' message if the branch does not exist.

##### 4. `updateBranch`
- **Endpoint**: PUT `https://ourbankURL/api/branches/:id`
- **Description**: Updates the details of a specific branch.
- **Request Body**:
  - Contains the updates for the branch (e.g., name, address, manager ID).
- **Response**:
  - Returns a success message upon successful update.
  - Sends a `404` status with a 'Branch not found' message if the branch does not exist.

##### 5. `deleteBranch`
- **Endpoint**:  `https://ourbankURL/api/branches/:id`
- **Description**: Deletes a specific branch by its ID.
- **Response**:
  - Returns a success message upon successful deletion.
  - Sends a `404` status with a 'Branch not found' message if the branch does not exist.
 

### Manager Management API

#### Overview of Controller Functions

##### 1. `getAllManagers`
- **Endpoint**: GET `https://ourbankURL/api/managers/`
- **Description**: Fetches and returns all managers from the database.
- **Response**:
  - Returns a JSON array of all managers.
  - Sends a `500` status response with an error message if an error occurs.

##### 2. `createManager`
- **Endpoint**: POST `https://ourbankURL/api/managers/`
- **Description**: Creates a new manager using data from the request body.
- **Request Body**:
  - `name`: The name of the manager.
  - `username`: The username for login.
  - `password`: The password for login (hashed before storing).
- **Response**:
  - Returns details of the newly created manager upon success.
  - Sends an error message if manager creation fails.

##### 3. `getManagerById`
- **Endpoint**: GET `https://ourbankURL/api/managers/:id`
- **Description**: Retrieves a specific manager by their ID.
- **Response**:
  - Returns manager details if found.
  - Sends a `404` status with a 'Manager not found' message if the manager does not exist.

##### 4. `updateManagerBranchId`
- **Endpoint**: PUT `https://ourbankURL/api/managers/:id`
- **Description**: Updates the branch ID associated with a specific manager.
- **Request Body**:
  - `Branch_ID`: The new branch ID to be associated with the manager.
- **Response**:
  - Returns a success message upon successful update.
  - Sends a `404` status if the manager is not found.

##### 5. `deleteManager`
- **Endpoint**: DELETE `https://ourbankURL/api/managers/:id`
- **Description**: Deletes a specific manager by their ID.
- **Response**:
  - Returns a success message upon successful deletion.
  - Sends a `404` status with a 'Manager not found' message if the manager does not exist.

##### 6. `loginManager`
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

##### 7. `verifyOtp`
- **Endpoint**: POST `https://ourbankURL/api/managers//verify-otp`
- **Description**: Verifies the OTP sent to the manager's email during login.
- **Request Body**:
  - `Manager_ID`: The ID of the manager.
  - `otp`: The OTP provided by the manager.
- **Response**:
  - Returns a success message and logs the manager in upon successful OTP verification.
  - Sends a `401` status with an 'Invalid OTP' message if the OTP does not match.




 
 

 









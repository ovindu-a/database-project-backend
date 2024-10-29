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




 
 

 









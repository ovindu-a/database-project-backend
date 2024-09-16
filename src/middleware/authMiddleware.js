const cookieParser = require('cookie-parser');
const JWT_SECRET = 'yourSecretKey'; // Change this to a strong secret
const jwt = require('jsonwebtoken');

// Middleware to verify JWT from cookies
const verifyCookie = (req, res, next) => {
  const token = req.cookies.token; // Get token from cookies
  if (!token) {
    return res.status(401).json({ message: 'Unauthorized' });
  }

  jwt.verify(token, JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: 'Invalid token' });
    }
    req.customerId = decoded.Customer_ID;
    console.log(req)
    next();
  });
};

// Middleware to create and set JWT token in cookie
const createJwtToken = (req, res, customerId) => {
  return token = jwt.sign({ Customer_ID: customerId }, JWT_SECRET, { expiresIn: '10m' });
};

module.exports = { verifyCookie, createJwtToken };
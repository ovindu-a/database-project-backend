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
    next();
  });
};

module.exports =  {verifyCookie};
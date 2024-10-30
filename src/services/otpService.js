const nodemailer = require('nodemailer');

const sendOtp = async (email, otp) => {
    const transporter = nodemailer.createTransport({
        service: 'gmail', // Use your email service
        auth: {
            user: 'g8database@gmail.com', // Your email
            pass: 'oqphdhneholoqwso' // Your email password
        }
    });

    // HTML Template with embedded OTP
    const htmlTemplate = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your OTP Code</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 600px;
                margin: 50px auto;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                overflow: hidden;
            }
            .header {
                background-color: #003366;
                color: #ffffff;
                padding: 20px;
                text-align: center;
            }
            .header h1 {
                margin: 0;
                font-size: 24px;
            }
            .content {
                padding: 30px;
                color: #333333;
            }
            .otp-box {
                font-size: 22px;
                font-weight: bold;
                color: #003366;
                background-color: #e6f2ff;
                padding: 10px 20px;
                margin: 20px 0;
                text-align: center;
                border-radius: 5px;
                letter-spacing: 2px;
            }
            .message {
                font-size: 16px;
                line-height: 1.6;
                color: #555555;
            }
            .footer {
                background-color: #003366;
                color: #ffffff;
                text-align: center;
                padding: 15px;
                font-size: 12px;
            }
            .footer p {
                margin: 0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>Your account Security</h1>
            </div>
            <div class="content">
                <p class="message">Dear Customer,</p>
                <p class="message">For your security, please use the following OTP (One-Time Password) to proceed with your transaction or log in. This code is valid for the next 10 minutes and should not be shared with anyone.</p>
                <div class="otp-box">
                    ${otp} <!-- Dynamic OTP goes here -->
                </div>
                <p class="message">If you did not request this OTP, please contact our customer support immediately.</p>
                <p class="message">Thank you for choosing our banking app. We are committed to keeping your account secure.</p>
            </div>
            <div class="footer">
                <p>&copy; 2023 Bank A. All rights reserved.</p>
                <p>Do not reply to this email. For assistance, please contact customer support.</p>
            </div>
        </div>
    </body>
    </html>`;

    const mailOptions = {
        from: 'g8database@gmail.com',
        to: 'g8database@gmail.com', // Customer's email address
        subject: 'Your OTP Code for Bank A',
        html: htmlTemplate // Send HTML content as email
    };

    await transporter.sendMail(mailOptions); // Send the email
};

const generateOtp = () => {
    return Math.floor(100000 + Math.random() * 900000).toString(); // Generate a 6-digit OTP
};

module.exports = { sendOtp, generateOtp };
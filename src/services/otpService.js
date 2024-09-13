const nodemailer = require('nodemailer');

const sendOtp = async (email, otp) => {
    const transporter = nodemailer.createTransport({
        service: 'gmail', // Use your email service
        auth: {
            user: 'g8database@gmail.com', // Your email
            pass: 'axxsyuvxgpgwkydj' // Your email password
        }
    });

    const mailOptions = {
        from: 'g8database@gmail.com',
        to: 'g8database@gmail.com', // Assuming customer has an Email field
        subject: 'Your OTP Code',
        text: `Your OTP code is ${otp}`
    };

    await transporter.sendMail(mailOptions); // Send the email
};

const generateOtp = () => {
    return Math.floor(100000 + Math.random() * 900000).toString(); // Generate a 6-digit OTP
};

module.exports = { sendOtp, generateOtp };
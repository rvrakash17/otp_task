import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTP Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOTPRequested = false;
  bool _isOTPValid = false;

  void _sendOTP() {
    setState(() {
      _isOTPRequested = true;
    });
    // Add logic to request OTP
    print('Send OTP to: ${_phoneController.text}');
    // Normally, connect this to your backend or OTP service provider.
  }

  void _login() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Login Successful"),
        content: Text("Phone: ${_phoneController.text}\nOTP: ${_otpController.text}"),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              setState(() {
                _isOTPRequested = false;
                _phoneController.clear();
                _otpController.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!_isOTPRequested) ...[
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _sendOTP,
                  child: Text('Send OTP'),
                ),
              ),
            ] else ...[
              Text("Phone: ${_phoneController.text}"),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                ),
                onChanged: (value) {
                  setState(() {
                    _isOTPValid = value.length == 6;
                  });
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _isOTPValid ? _login : null,
                  child: Text('Login'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

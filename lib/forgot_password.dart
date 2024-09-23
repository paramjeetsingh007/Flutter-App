import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Forgot Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Enter your email'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Add logic to send password reset link
                },
                child: Text('Send Reset Link'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to login
                },
                child: Text('Back to Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

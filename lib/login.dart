import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Define your valid email and password
    const String validEmail = 'p@gmail.com';
    const String validPassword = '12345';

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Instagram', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email or Username'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Check if the entered email and password are correct
                  if (emailController.text == validEmail && passwordController.text == validPassword) {
                    // Navigate to the home page if credentials are correct
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Show an error message if credentials are incorrect
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Invalid email or password.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Log In'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotpassword');
                },
                child: Text('Forgot Password?'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Don’t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


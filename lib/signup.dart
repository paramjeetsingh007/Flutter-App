import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                controller: fullNameController,
                decoration: InputDecoration(hintText: 'Full Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(hintText: 'Username'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true, // Hide password input
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Check if all the fields are filled
                  if (fullNameController.text.isNotEmpty &&
                      usernameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    
                    // Navigate to the home page
                    Navigator.pushReplacementNamed(context, '/home');
                    
                    // Optionally, you can print the details in the console (for testing)
                    print('Full Name: ${fullNameController.text}');
                    print('Username: ${usernameController.text}');
                    print('Email: ${emailController.text}');
                    print('Password: ${passwordController.text}');
                  } else {
                    // Show an error message if fields are empty
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Please fill all the fields'),
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
                child: Text('Sign Up'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to login page
                },
                child: Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

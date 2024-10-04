import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored email and password
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');
    bool? isLoggedIn = prefs.getBool('isLoggedIn'); // Check if user is already logged in

    // If user is already logged in, navigate to home
    if (isLoggedIn == true) {
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    // Check if the entered email and password match the stored values
    if (emailController.text == storedEmail && passwordController.text == storedPassword) {
      // Navigate to the home page if credentials are correct
      await prefs.setBool('isLoggedIn', true); // Set login state to true
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
  }

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
                onPressed: () => _login(context), // Call the login method
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

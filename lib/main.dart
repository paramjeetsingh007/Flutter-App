import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'signup.dart';
import 'forgot_password.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/signup': (context) => SignUpPage(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  Future<void> _checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn'); // Check if user is already logged in

    // Navigate to the appropriate page after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (isLoggedIn == true) {
        Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomePage
      } else {
        Navigator.pushReplacementNamed(context, '/login'); // Navigate to LoginPage
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color for splash screen
      body: Center(
        child: Image.asset('assets/Logo.jpg'), // Your splash logo
      ),
    );
  }
}

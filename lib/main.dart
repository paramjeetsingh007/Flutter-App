import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'forgot_password.dart';
import 'Home .dart';

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
        '/': (context) => LoginPage(),
        '/home': (context) =>HomePage(),
        '/signup': (context) => SignUpPage(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final dynamic user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user['firstName']} ${user['lastName']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(user['image'], height: 100, width: 100),
            ),
            SizedBox(height: 20),
            Text('First Name: ${user['firstName']}', style: TextStyle(fontSize: 18)),
            Text('Last Name: ${user['lastName']}', style: TextStyle(fontSize: 18)),
            Text('Age: ${user['age']}', style: TextStyle(fontSize: 18)),
            Text('Gender: ${user['gender']}', style: TextStyle(fontSize: 18)),
            Text('Email: ${user['email']}', style: TextStyle(fontSize: 18)),
            Text('Phone: ${user['phone']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

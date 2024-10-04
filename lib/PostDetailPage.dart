import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final dynamic post;

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(post['body'], style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Reactions:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Likes: ${post['reactions']['likes']}'),
            Text('Dislikes: ${post['reactions']['dislikes']}'),
            SizedBox(height: 10),
            Text('Views: ${post['views']}'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe['image'], fit: BoxFit.cover, width: double.infinity, height: 300),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ingredients:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  for (var ingredient in recipe['ingredients'])
                    Text('• $ingredient', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text(
                    'Instructions:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  for (var instruction in recipe['instructions'])
                    Text('• $instruction', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text(
                    'Rating: ${recipe['rating']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Meal Type: ${recipe['mealType'].join(', ')}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

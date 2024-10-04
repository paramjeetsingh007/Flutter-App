import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
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
            Image.network(product['images'][0], fit: BoxFit.cover, width: double.infinity, height: 300),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: \$${product['price']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Category: ${product['category']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Discount: ${product['discountPercentage']}%',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rating: ${product['rating']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description: ${product['description']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Reviews:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...product['reviews'].map<Widget>((review) => Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          '${review['reviewerName']}: ${review['comment']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class BookDetailPage1 extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailPage1({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/${book['image']}',
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              book['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'By ${book['subtitle']}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Synopsis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              book['synopsis'], // Ensure the book data includes a 'synopsis' key
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text(book['rating'].toString()),
                    Text('700+ Reviews', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.person, color: Colors.blue),
                    Text('25+'),
                    Text('Reading Now', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.book, color: Colors.green),
                    Text('345'),
                    Text('Books Sold', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Add To Cart',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
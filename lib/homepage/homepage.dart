import 'package:flutter/material.dart';
import 'package:perpustakaan/bookpage/BookDetailPage1.dart';
import 'package:perpustakaan/homepage/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> books = [
    {'name': 'Mantapo Jiwa', 'subtitle': 'By: Jerome Polin Sijabat', 'rating': 4.5, 'isFavorite': false, 'image': 'mantapo_jiwa.jpg', 'synopsis': 'Synopsis of Mantapo Jiwa'},
    {'name': 'Tuhan Ada Dimana', 'subtitle': 'By: Hasan Al-Basri', 'rating': 4.8, 'isFavorite': false, 'image': 'tuhan_ada_dimana.jpg', 'synopsis': 'Synopsis of Tuhan Ada Dimana'},
    {'name': 'Cerita Kita', 'subtitle': 'By: Dewi Lestari', 'rating': 4.3, 'isFavorite': false, 'image': 'cerita_kita.jpg', 'synopsis': 'Synopsis of Cerita Kita'},
    {'name': 'Mimpi Indah', 'subtitle': 'By: Raditya Dika', 'rating': 4.7, 'isFavorite': false, 'image': 'mimpi_indah.jpg', 'synopsis': 'Synopsis of Mimpi Indah'},
    {'name': 'Langit Biru', 'subtitle': 'By: Tere Liye', 'rating': 4.6, 'isFavorite': false, 'image': 'langit_biru.jpg', 'synopsis': 'Synopsis of Langit Biru'},
  ];

  void toggleFavorite(int index) {
    setState(() {
      books[index]['isFavorite'] = !books[index]['isFavorite'];
    });
  }

  void navigateToDetailPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage1(book: books[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Hello, Yosi',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/profile_image.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 19),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[350], // Warna abu-abu muda
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8), // Padding di sekitar TextField
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'search...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8), // Jarak antara TextField dan ikon
                    GestureDetector(
                      onTap: () {
                        // Aksi ketika ikon ditekan
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.menu, // Ganti dengan ikon yang sesuai
                          color: Colors.white, // Warna ikon
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Trending'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Favorite'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Best Seller'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Seller',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  height: 200, // Atur tinggi sesuai kebutuhan Anda
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length, // Ganti dengan jumlah item yang Anda miliki
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToDetailPage(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 150, // Atur lebar sesuai kebutuhan Anda
                            decoration: BoxDecoration(
                              color: Colors.grey[500], // Warna abu-abu untuk padding
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end, // Posisi teks ke bawah
                                crossAxisAlignment: CrossAxisAlignment.start, // Posisi teks ke kiri
                                children: [
                                  Text(
                                    books[index]['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start, // Teks di kiri
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    books[index]['subtitle'],
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.start, // Teks di kiri
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start, // Posisi ikon dan teks ke kiri
                                    children: [
                                      GestureDetector(
                                        onTap: () => toggleFavorite(index),
                                        child: Icon(
                                          books[index]['isFavorite'] ? Icons.star : Icons.star_border,
                                          color: books[index]['isFavorite'] ? Colors.amber : Colors.black,
                                          size: 17,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        books[index]['rating'].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Need To Read",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
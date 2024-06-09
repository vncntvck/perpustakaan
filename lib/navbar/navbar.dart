import 'package:flutter/material.dart';
import 'package:perpustakaan/homepage/homepage.dart';
import 'package:perpustakaan/homepage/profile.dart';
import 'package:perpustakaan/homepage/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavbarScreen(),
    );
  }
}

class NavbarScreen extends StatefulWidget {
  @override
  _NavbarScreenState createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _selectedIndex == 0
            ? Homepage()
            : _selectedIndex == 1
                ? pencarian()
                : Profile(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: CustomAnimatedIcon(
              icon: Icons.home,
              isSelected: _selectedIndex == 0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomAnimatedIcon(
              icon: Icons.search,
              isSelected: _selectedIndex == 1,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: CustomAnimatedIcon(
              icon: Icons.person,
              isSelected: _selectedIndex == 2,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CustomAnimatedIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const CustomAnimatedIcon({required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30.0),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isSelected ? 3.0 : 0.0,
          width: isSelected ? 30.0 : 0.0,
          color: Colors.blue,
          margin: EdgeInsets.only(top: 5.0),
        ),
      ],
    );
  }
}
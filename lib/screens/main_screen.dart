import 'package:flutter/material.dart';
// Ganti 'project_name' dengan nama proyek Anda (folder lib)
import 'add_category_screen.dart'; 
import 'package:rpl_fr/screens/dashboard_screen.dart'; 
import 'dart:ui'; // Untuk BackdropFilter
import '../utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar halaman sesuai desain baru
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const Center(child: Text('Halaman Statistik')), // Placeholder
    const AddCategoryScreen(), // Halaman Kategori
    const Center(child: Text('Halaman Profil')), // Placeholder
  ];

  // Daftar judul untuk AppBar
  static const List<String> _widgetTitles = <String>[
    'Hello!', // Judul untuk Dashboard
    'Statistic', // Judul untuk Statistik
    'Category', // Judul untuk Kategori
    'Profile', // Judul untuk Profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TAMBAHKAN APPBAR DI SINI
      appBar: AppBar(
        title: Text(_widgetTitles.elementAt(_selectedIndex)),
      ),
      
      // HAPUS 'Center' DARI BODY
      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Homepage',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Statistic',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
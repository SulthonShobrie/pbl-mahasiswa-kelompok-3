// lib/screens/main_navigation_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'jadwal_screen.dart';
import 'kelas_screen.dart';
import 'akun_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan sesuai menu yang dipilih
  final List<Widget> _screens = [
    const HomeScreen(),
    const JadwalScreen(),
    const KelasScreen(),
    const AkunScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF1E3A8A),
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: "Jadwal",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.class_rounded),
              label: "Kelas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Akun",
            ),
          ],
        ),
      ),
    );
  }
}

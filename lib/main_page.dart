import 'package:flutter/material.dart';
import 'package:myapp/dashboard_page.dart';
import 'package:myapp/favorites_page.dart';

// Ini halaman utama setelah user berhasil login.
// Isinya ada navigasi bawah buat pindah-pindah halaman.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Buat nyimpen index tab yang lagi aktif.
  int _selectedIndex = 0;

  // Daftar halaman yang bisa diakses dari navigasi bawah.
  static const List<Widget> _pages = <Widget>[
    DashboardPage(), // Halaman Beranda (index 0)
    FavoritesPage(),   // Halaman Favorit (index 1)
  ];

  // Fungsi ini dipanggil pas user nge-klik salah satu item navigasi.
  void _onItemTapped(int index) {
    setState(() {
      // Update index-nya, nanti UI-nya bakal otomatis ganti halaman.
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Nampilin halaman yang sesuai dengan index yang lagi dipilih.
      body: _pages.elementAt(_selectedIndex),
      // Ini widget navigasi bawahnya.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home), // Ikon pas lagi aktif.
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite), // Ikon pas lagi aktif.
            label: 'Favorit',
          ),
        ],
        currentIndex: _selectedIndex, // Item mana yang lagi nyala.
        onTap: _onItemTapped,       // Fungsi yang dipanggil pas item diklik.
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF6B00), // Warna item yang aktif.
        unselectedItemColor: Colors.grey,           // Warna item yang nggak aktif.
        showUnselectedLabels: true, // Tunjukin labelnya walau nggak aktif.
        type: BottomNavigationBarType.fixed, // Biar posisi itemnya tetep.
      ),
    );
  }
}

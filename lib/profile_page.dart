import 'package:flutter/material.dart';
import 'package:myapp/user_model.dart';
import 'package:provider/provider.dart';
import 'package:myapp/favorites_provider.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  // Fungsi untuk proses keluar
  void _logout(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan jumlah resep favorit dari provider.
    final favoriteCount = Provider.of<FavoritesProvider>(context).favoriteRecipes.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Color(0xFFFF6B00), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- Bagian Header Profil ---
            _buildProfileHeader(user, favoriteCount),
            // Spacer akan mendorong tombol keluar ke bagian bawah.
            const Spacer(),
            // --- Tombol Keluar ---
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // Widget untuk header profil: foto, nama, email, dan jumlah favorit.
  Widget _buildProfileHeader(User user, int favoriteCount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundColor: Color(0xFFFDEBE3),
          child: Icon(Icons.person, size: 36, color: Color(0xFFF4511E)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // --- Statistik Favorit ---
        Column(
          children: [
            Text(
              favoriteCount.toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFF6B00)),
            ),
            const Text('Favorit', style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  // Widget untuk tombol keluar.
  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _logout(context),
      icon: const Icon(Icons.logout, color: Colors.white),
      label: const Text(
        'Keluar',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD32F2F),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }
}

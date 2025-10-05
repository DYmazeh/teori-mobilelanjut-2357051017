import 'package:flutter/material.dart';
import 'package:myapp/recipe_detail_page.dart';
import 'package:myapp/recipe_model.dart';
import 'package:myapp/favorites_page.dart';

// Halaman utama aplikasi yang berfungsi sebagai dashboard.
// Menampilkan sapaan, pencarian, kategori, resep unggulan, dan rekomendasi.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), // Warna latar belakang utama halaman.
      // Bagian atas halaman (AppBar) dengan judul dan tombol aksi.
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFBFB),
        elevation: 0, // Hilangkan bayangan di bawah AppBar.
        // Judul sapaan dengan dua gaya teks yang berbeda.
        title: RichText(
          text: const TextSpan(
            text: 'Halo Cookers\n',
            style: TextStyle(color: Colors.black54, fontSize: 18),
            children: <TextSpan>[
              TextSpan(
                text: 'Mari Masak Hari Ini',
                style: TextStyle(
                  color: Color(0xFFFF6B00),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        // Tombol di sebelah kanan AppBar.
        actions: [
          IconButton(
            onPressed: () {
              // Navigasi ke halaman favorit saat tombol ditekan.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
            icon: const Icon(Icons.favorite_border, color: Color(0xFFFF6B00), size: 28),
            tooltip: 'Favorit', // Teks bantuan saat tombol ditahan.
          ),
        ],
      ),
      // Konten utama halaman yang dapat digulir.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Bagian Pencarian ---
              Row(
                children: [
                  // Input field untuk mencari resep.
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari kemauanmu disini',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none, // Hilangkan border.
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Tombol aksi pencarian.
                  FloatingActionButton(
                    onPressed: () { /* Logika pencarian ditambahkan di sini */ },
                    backgroundColor: const Color(0xFFFF6B00),
                    elevation: 1,
                    child: const Icon(Icons.search, color: Colors.white, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // --- Bagian Chip Kategori ---
              _buildCategoryChips(),
              const SizedBox(height: 24),
              // --- Kartu Resep Unggulan ---
              _buildFeaturedCard(context),
              const SizedBox(height: 24),
              // --- Judul Bagian Rekomendasi ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rekomendasi Untukmu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () { /* Navigasi ke halaman "lihat semua" */ },
                    child: const Text(
                      'Lihat semua',
                      style: TextStyle(color: Color(0xFFFF6B00)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // --- Grid Rekomendasi Resep ---
              _buildRecommendationGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membangun deretan chip kategori.
  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8.0, // Jarak horizontal antar chip.
      runSpacing: 8.0, // Jarak vertikal antar baris chip.
      children: <Widget>[
        _buildChip('Sarapan'),
        _buildChip('Makan Siang'),
        _buildChip('Makan Malam'),
        _buildChip('Cemilan'),
      ],
    );
  }

  // Widget untuk membuat satu chip kategori.
  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade300), // Border tipis.
      ),
    );
  }

  // Widget untuk membangun kartu resep unggulan ("Resep Hari Ini").
  Widget _buildFeaturedCard(BuildContext context) {
    // Jika tidak ada resep, jangan tampilkan apa-apa.
    if (recipes.isEmpty) return const SizedBox.shrink();
    
    // Ambil resep pertama dari daftar sebagai resep unggulan.
    final featuredRecipe = recipes.first;
    return GestureDetector(
      // Navigasi ke detail resep saat kartu ditekan.
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: featuredRecipe))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Lapisan 1: Gambar Latar Belakang.
            Image.network(
              featuredRecipe.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              // Tampilkan placeholder jika gambar gagal dimuat.
              errorBuilder: (context, error, stackTrace) {
                return Container(
                    height: 220,
                    color: const Color(0xFFF47A46),
                    child: const Center(child: Icon(Icons.photo, color: Colors.white, size: 50)));
              },
            ),
            // Lapisan 2: Gradien untuk memastikan teks terbaca.
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFF47A46),
                    const Color(0xFFF47A46),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0], // Kontrol persebaran gradien.
                ),
              ),
            ),
            // Lapisan 3: Konten teks dan tombol.
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'RESEP HARI INI',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    featuredRecipe.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        shadows: [Shadow(blurRadius: 10.0, color: Colors.black26, offset: Offset(2.0, 2.0))]),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hangat, gurih, dan siap dalam 20 menit.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: featuredRecipe))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFF47A46),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Lihat Resep', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun grid resep rekomendasi.
  Widget _buildRecommendationGrid(BuildContext context) {
    // Tampilkan semua resep kecuali resep pertama (yang sudah jadi unggulan).
    final recommendationRecipes = recipes.skip(1).toList();

    // Jika tidak ada resep rekomendasi, jangan tampilkan apa-apa.
    if (recommendationRecipes.isEmpty) return const Text('Tidak ada resep lain untuk direkomendasikan.');

    // Gunakan LayoutBuilder untuk membuat grid yang responsif.
    return LayoutBuilder(
      builder: (context, constraints) {
        // Tentukan jumlah kolom berdasarkan lebar layar.
        int crossAxisCount;
        if (constraints.maxWidth > 900) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 2;
        }

        const double childAspectRatio = 0.75; // Rasio aspek untuk setiap item di grid.

        return GridView.builder(
          shrinkWrap: true, // Agar GridView hanya memakan ruang yang dibutuhkan.
          physics: const NeverScrollableScrollPhysics(), // Matikan scroll internal GridView.
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16, // Jarak horizontal antar item.
            mainAxisSpacing: 16, // Jarak vertikal antar item.
            childAspectRatio: childAspectRatio,
          ),
          itemCount: recommendationRecipes.length,
          itemBuilder: (context, index) {
            final recipe = recommendationRecipes[index];
            // Setiap item di grid bisa ditekan.
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)),
                );
              },
              // Tampilan satu kartu resep.
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFFAF6F4),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 10, offset: const Offset(0, 4))]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar resep.
                        Expanded(
                          child: Image.network(
                            recipe.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey));
                            },
                          ),
                        ),
                        // Informasi di bawah gambar.
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nama resep.
                              Text(
                                recipe.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              // Informasi rating dan waktu masak.
                              Row(
                                children: [
                                  Icon(Icons.star, size: 18, color: Colors.amber[700]),
                                  const SizedBox(width: 4),
                                  Text(recipe.rating.toString(), style: TextStyle(color: Colors.grey[800], fontSize: 14)),
                                  const Spacer(), // Memberi jarak maksimal di antara dua item.
                                  Icon(Icons.timer_outlined, size: 16, color: Colors.grey[700]),
                                  const SizedBox(width: 4),
                                  Text('${recipe.cookingTime} min', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

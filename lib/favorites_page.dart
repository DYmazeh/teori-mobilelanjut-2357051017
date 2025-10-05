import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/favorites_provider.dart';
import 'package:myapp/recipe_detail_page.dart';

// Halaman ini buat nampilin semua resep yang udah ditandai sebagai favorit.
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dengerin perubahan dari provider favorit.
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteRecipes = favoritesProvider.favoriteRecipes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep Favorit', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF6B00))),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: favoriteRecipes.isEmpty
          // Kalo daftar favoritnya kosong, tampilin pesan ini.
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Color(0xFFFF6B00)),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada resep favorit',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const Text(
                    'Yuk, mulai tambahkan resep kesukaanmu!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          // Kalo ada, tampilin daftarnya.
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                // Setiap item di daftar ini adalah kartu resep.
                return Card(
                  color: const Color(0xFFFF6B00),
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    // Gambar resep di sebelah kiri.
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        recipe.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: const Color(0xFFF47A46),
                            child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 40),
                          );
                        },
                      ),
                    ),
                    // Judul dan info singkat resep.
                    title: Text(recipe.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    subtitle: Text('${recipe.cookingTime} min | ${recipe.difficulty}', style: TextStyle(color: Colors.white)),
                    // Tombol hapus dari favorit.
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.white),
                      onPressed: () {
                        // Langsung panggil fungsi buat hapus dari favorit.
                        favoritesProvider.toggleFavorite(recipe);
                      },
                    ),
                    // Kalo itemnya diklik, buka halaman detail.
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(recipe: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

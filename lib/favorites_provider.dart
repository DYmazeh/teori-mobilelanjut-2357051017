import 'package:flutter/foundation.dart';
import 'package:myapp/recipe_model.dart';

// Kelas ini tugasnya buat ngurusin data resep favorit di seluruh aplikasi.
// ChangeNotifier bakal ngasih tau widget-widget kalo ada data yang berubah.
class FavoritesProvider with ChangeNotifier {
  
  // Ini daftar pribadi buat nyimpen resep-resep yang difavoritkan.
  final List<Recipe> _favoriteRecipes = [];

  // Ini cara buat widget lain ngintip daftar resep favorit (tapi cuma bisa baca).
  List<Recipe> get favoriteRecipes => _favoriteRecipes;

  // Fungsi buat nambahin atau ngapus resep dari daftar favorit.
  void toggleFavorite(Recipe recipe) {
    if (_favoriteRecipes.contains(recipe)) {
      // Kalo resepnya udah ada, berarti user mau hapus dari favorit.
      _favoriteRecipes.remove(recipe);
    } else {
      // Kalo belum ada, berarti user mau nambahin ke favorit.
      _favoriteRecipes.add(recipe);
    }
    // Ini yang paling penting! Ngasih tau semua widget yang "mendengarkan"
    // kalo ada perubahan data, biar mereka bisa update tampilan.
    notifyListeners();
  }

  // Fungsi simpel buat ngecek apakah suatu resep udah jadi favorit atau belum.
  bool isFavorite(Recipe recipe) {
    return _favoriteRecipes.contains(recipe);
  }
}

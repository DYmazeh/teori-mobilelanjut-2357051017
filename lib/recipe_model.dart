/// Ini cetakan (blueprint) buat data resep.
/// Setiap resep di aplikasi kita harus punya data-data di bawah ini.
class Recipe {
  final String name; // Nama resepnya
  final String imageUrl; // Link gambar buat ditampilin
  final List<String> ingredients; // Daftar bahan-bahan
  final List<String> steps; // Langkah-langkah masaknya
  final int cookingTime; // Waktu masak (dalam menit)
  final int calories; // Jumlah kalori (kcal)
  final int servings; // Bisa buat berapa porsi
  final double rating; // Rating resepnya (misal: 4.5)
  final String difficulty; // Tingkat kesulitan (Mudah, Sedang, Sulit)

  // Ini constructor-nya, dipake buat bikin objek resep baru.
  Recipe({
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.cookingTime,
    required this.calories,
    required this.servings,
    required this.rating,
    required this.difficulty,
  });
}

// Ini daftar resep "dummy" kita.
// Nanti kalo pake database beneran, bagian ini bakal diganti.
final List<Recipe> recipes = [
  Recipe(
    name: 'Nasi Goreng Spesial',
    imageUrl: 'https://bing.com/th?id=OSK.ad20e39826790ab31e2d013c670afd22', 
    ingredients: [
      '2 piring nasi putih',
      '2 sdm minyak goreng',
      '1 butir telur, kocok lepas',
      '100 gr daging ayam, potong dadu',
      '2 siung bawang putih, cincang halus',
      '3 buah cabai rawit, iris serong',
      '1 sdm kecap manis',
      'Garam dan merica secukupnya',
    ],
    steps: [
      'Panaskan minyak, tumis bawang putih dan cabai hingga harum.',
      'Masukkan potongan ayam, masak hingga berubah warna.',
      'Pinggirkan ayam, masukkan telur, orak-arik hingga matang.',
      'Masukkan nasi, aduk rata.',
      'Bumbui dengan kecap manis, garam, dan merica. Aduk hingga semua tercampur rata.',
      'Sajikan selagi hangat.',
    ],
    cookingTime: 20,
    calories: 450,
    servings: 2,
    rating: 4.7,
    difficulty: 'Mudah',
  ),
  Recipe(
    name: 'Ayam Goreng Lengkuas',
    imageUrl: 'https://bing.com/th?id=OSK.9c1b2c9d73718c43900c6b7d47438f54',
    ingredients: [
      '1 ekor ayam, potong 8 bagian',
      '500 ml air',
      '3 lembar daun salam',
      '2 batang serai, memarkan',
      'Minyak untuk menggoreng',
      'Bumbu halus: 8 siung bawang merah, 4 siung bawang putih, 1 sdt ketumbar, 1 ruas kunyit, garam',
    ],
    steps: [
      'Ungkep ayam bersama air, bumbu halus, daun salam, dan serai hingga air menyusut dan bumbu meresap.',
      'Panaskan minyak dalam jumlah banyak.',
      'Goreng ayam hingga berwarna kuning keemasan.',
      'Angkat dan tiriskan.',
      'Sajikan dengan sambal dan lalapan.',
    ],
    cookingTime: 45,
    calories: 550,
    servings: 4,
    rating: 4.8,
    difficulty: 'Sedang',
  ),
  Recipe(
    name: 'Soto Ayam Lamongan',
    imageUrl: 'https://bing.com/th?id=OSK.9f92ccc5f8a837006e695385967c1d57',
    ingredients: [
      '1/2 ekor ayam',
      '2 liter air',
      '200 gr tauge, seduh air panas',
      '100 gr soun, rendam air panas',
      '2 batang seledri, iris halus',
      'Bawang goreng secukupnya',
      'Bumbu halus: 6 siung bawang merah, 3 siung bawang putih, 1 ruas kunyit, 1/2 sdt merica, garam',
      'Pelengkap: telur rebus, jeruk nipis, sambal',
    ],
    steps: [
      'Rebus ayam hingga matang. Angkat dan suwir-suwir dagingnya. Sisihkan kaldunya.',
      'Tumis bumbu halus hingga harum, masukkan ke dalam kaldu.',
      'Masak kaldu hingga mendidih dan bumbu meresap.',
      'Tata soun, tauge, dan suwiran ayam dalam mangkuk.',
      'Siram dengan kuah soto panas.',
      'Taburi dengan seledri dan bawang goreng. Sajikan dengan pelengkap.',
    ],
    cookingTime: 60,
    calories: 400,
    servings: 4,
    rating: 4.9,
    difficulty: 'Sedang',
  ),
  Recipe(
    name: 'Gado-gado',
    imageUrl: 'https://bing.com/th?id=OSK.a8191df5ad7395b42400359215941352',
    ingredients: [
      '200g kangkung, siangi',
      '100g tauge, buang akarnya',
      '1 buah tahu putih, goreng',
      '1 papan tempe, goreng',
      '1 buah mentimun, iris tipis',
      'Lontong atau nasi',
      'Saus Kacang: 200g kacang tanah goreng, 3 siung bawang putih, 5 buah cabai rawit, 1 sdt terasi, 1 sdm gula merah, air asam jawa, garam',
    ],
    steps: [
      'Rebus sayuran (kangkung dan tauge) sebentar, angkat dan tiriskan.',
      'Haluskan semua bahan saus kacang, tambahkan air sedikit demi sedikit hingga kekentalan pas.',
      'Tata lontong, sayuran, tahu, dan tempe di atas piring.',
      'Siram dengan saus kacang.',
      'Sajikan dengan kerupuk dan bawang goreng.',
    ],
    cookingTime: 35,
    calories: 350,
    servings: 2,
    rating: 4.6,
    difficulty: 'Mudah',
  ),
  Recipe(
    name: 'Rendang Sapi',
    imageUrl: 'https://bing.com/th?id=OSK.3d77672a9d29e58d3a707aeaa2f80130',
    ingredients: [
      '500g daging sapi, potong sesuai selera',
      '1 liter santan dari 1 butir kelapa',
      '2 batang serai, memarkan',
      '3 lembar daun jeruk',
      '1 lembar daun kunyit, simpulkan',
      'Bumbu Halus: 10 buah cabai merah, 5 siung bawang merah, 3 siung bawang putih, 1 ruas jahe, 1 ruas lengkuas, 1 sdt ketumbar, garam',
    ],
    steps: [
      'Tumis bumbu halus hingga harum, masukkan serai, daun jeruk, dan daun kunyit.',
      'Masukkan daging, aduk hingga berubah warna.',
      'Tuang santan, masak dengan api kecil sambil terus diaduk hingga santan mengering dan mengeluarkan minyak.',
      'Pastikan rendang benar-benar kering dan bumbu meresap.',
      'Rendang siap disajikan.',
    ],
    cookingTime: 180, // 3 hours
    calories: 600,
    servings: 5,
    rating: 5.0,
    difficulty: 'Sulit',
  ),
  Recipe(
    name: 'Mie Goreng Jawa',
    imageUrl: 'https://bing.com/th?id=OSK.dccd50073140fb33e01b3b3e675e7f8f',
    ingredients: [
      '200g mie telur, rebus dan tiriskan',
      '100g udang, kupas',
      '5 butir bakso, iris',
      '1 ikat sawi hijau, potong-potong',
      '2 sdm kecap manis',
      '1 sdm saus tiram',
      'Bumbu Halus: 3 siung bawang putih, 2 butir kemiri, 1/2 sdt merica butiran',
    ],
    steps: [
      'Tumis bumbu halus hingga harum.',
      'Masukkan udang dan bakso, masak hingga berubah warna.',
      'Tambahkan sawi, aduk hingga layu.',
      'Masukkan mie, kecap manis, dan saus tiram. Aduk rata.',
      'Koreksi rasa, tambahkan garam jika perlu.',
      'Sajikan dengan taburan bawang goreng dan irisan seledri.',
    ],
    cookingTime: 25,
    calories: 500,
    servings: 2,
    rating: 4.7,
    difficulty: 'Mudah',
  )
];

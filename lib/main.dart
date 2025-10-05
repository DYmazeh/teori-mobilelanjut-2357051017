import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/favorites_provider.dart';
import 'package:myapp/login_page.dart';

// Ini titik awal aplikasi kita, langsung jalanin MyApp.
void main() {
  runApp(const MyApp());
}

// Widget utama yang ngebungkus semua aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider ini buat ngelola resep favorit di seluruh aplikasi.
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
        title: 'Resep Makanan',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Halaman pertama yang muncul ya login dulu.
        home: LoginPage(),
        // Biar nggak ada banner "Debug" yang ganggu.
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

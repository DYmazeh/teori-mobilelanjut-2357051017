import 'package:flutter/material.dart';

// Halaman buat user baru daftar akun.
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7), // Latar belakang abu-abu muda.
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Tombol panah buat balik ke halaman sebelumnya (login).
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Buat Akun Baru', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 const SizedBox(height: 24),
                // Field buat isi nama.
                TextFormField(
                  decoration: _buildInputDecoration('Nama Lengkap', Icons.person_outline),
                ),
                const SizedBox(height: 16),

                // Field buat isi email.
                TextFormField(
                  decoration: _buildInputDecoration('Email', Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Field buat isi password.
                TextFormField(
                  decoration: _buildInputDecoration('Password', Icons.lock_outline),
                  obscureText: true, // Biar password-nya jadi bintang-bintang.
                ),
                 const SizedBox(height: 16),

                // Field buat konfirmasi password.
                TextFormField(
                  decoration: _buildInputDecoration('Konfirmasi Password', Icons.lock_outline),
                  obscureText: true,
                ),
                const SizedBox(height: 32),

                // Tombol buat daftar.
                ElevatedButton(
                   onPressed: () {
                    // Kalo tombol ini ditekan, balik ke halaman login.
                    // Nanti di sini bisa ditambahin logika buat nyimpen data user.
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B00), // Warna oranye khas.
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                 const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Atur gaya field input biar konsisten.
   InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey[500]),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      // Border pas field-nya lagi aktif (diklik).
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6B00), width: 2),
      ),
    );
  }
}

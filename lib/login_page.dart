import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main_page.dart';
import 'package:myapp/register_page.dart';

// Ini halaman buat user login.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Buat ngatur password keliatan atau enggak.
  bool _obscureText = true;

  // Fungsi buat ganti ikon mata di password field.
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F4), // Warna latar belakang biar adem.
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Bagian header atas (Logo & Slogan).
                _buildHeader(),
                const SizedBox(height: 24),
                // Form buat ngisi email dan password.
                _buildLoginForm(context),
                const SizedBox(height: 24),
                // Bagian footer (chip & link daftar).
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buat nampilin header.
  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF48A62), // Oranye kalem.
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'RESEPIN',
                  style: TextStyle(color: Colors.grey, fontSize: 14, letterSpacing: 1.5),
                ),
                Text(
                  'Masak Enak, Set-Sat-Set',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Widget buat nampilin form login.
  Widget _buildLoginForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          // Kasih bayangan biar keliatan ngambang.
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Masuk',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Temukan inspirasi resep harian favoritmu.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          // Field input email.
          TextFormField(
            decoration: _buildInputDecoration(hintText: 'nama@email.com'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const Text('Kata sandi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          // Field input password.
          TextFormField(
            obscureText: _obscureText, // Sembunyiin atau tampilin password.
            decoration: _buildInputDecoration(
              hintText: '********',
              // Ikon mata buat toggle visibilitas password.
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Tombol buat masuk.
          ElevatedButton(
            onPressed: () {
              // Kalo berhasil, langsung lempar ke halaman utama.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF4511E), // Oranye cerah.
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Masuk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Dengan masuk, kamu setuju dengan Ketentuan &\nKebijakan Privasi.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buat nampilin footer.
  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildChip('Cepat'),
            _buildChip('Praktis'),
            _buildChip('Enak'),
          ],
        ),
        const SizedBox(height: 24),
        // Teks buat ngajak daftar.
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            children: <TextSpan>[
              const TextSpan(text: 'Belum punya akun? '),
              TextSpan(
                text: 'Daftar',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF4511E),
                ),
                // Kalo 'Daftar' diklik, pindah ke halaman registrasi.
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Bikin chip kecil di bawah.
  Widget _buildChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.black54)),
      backgroundColor: const Color(0xFFEDEAE8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.transparent),
      ),
    );
  }

  // Atur gaya dekorasi buat field input biar seragam.
  InputDecoration _buildInputDecoration({String? hintText, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF9F6F4),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none, // Nggak pake border.
      ),
      // Border pas field-nya di-klik.
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFF4511E), width: 2),
      ),
    );
  }
}

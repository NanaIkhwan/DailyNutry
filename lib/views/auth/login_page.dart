import 'package:dailynutryapp/views/auth/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:dailynutryapp/services/google_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscurePassword = true; // untuk show/hide password

  final GoogleAuthService _googleAuthService = GoogleAuthService();

  // Fungsi login Firebase
  signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // ⬅️ Tambahkan ini: Sync user ke Flask
      // await syncUserToFlask();

      if (!mounted) return;
      // print('login berhasil');
      Navigator.pushReplacementNamed(context, '/beranda');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login gagal')));
    }
  }

  void signInWithGoogle() async {
    final User? user = await _googleAuthService.signInWithGoogle();

    if (!mounted) return;

    if (user != null) {
      // Sign-In Google berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil Masuk sebagai ${user.email}')),
      );
      Navigator.pushReplacementNamed(context, '/beranda');
    } else {
      // Sign-In Google gagal atau dibatalkan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Google Gagal. Cek log untuk detail.'),
        ),
      );
    }
  }

  Future<void> syncUserToFlask() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final token = await user.getIdToken();

      await http.post(
        Uri.parse("http://127.0.0.1:5000/api/sync-user"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"token": token, "email": user.email}),
      );
    } catch (e) {
      debugPrint("Gagal sync ke Flask: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Animasi Lottie
              Lottie.asset('assets/images/welcome.json', height: 250),
              const SizedBox(height: 40),

              // Judul
              Text("Masuk", style: GoogleFonts.roboto(fontSize: 50)),
              const SizedBox(height: 40),

              // Input email
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  label: Text('Masukkan Email'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input password dengan show/hide
              TextField(
                controller: password,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  label: const Text("Masukkan Password"),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Tombol login
              ElevatedButton(
                onPressed: signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 20, 216, 79),
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(270, 45),
                ),
                child: const Text("Masuk"),
              ),
              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('ATAU', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- TOMBOL GOOGLE SIGN-IN BARU ---
              ElevatedButton.icon(
                onPressed: signInWithGoogle, // Panggil fungsi baru
                icon: Image.asset(
                  'assets/images/google.png', // Ganti dengan path logo Google Anda
                  height: 24.0,
                ),
                label: const Text('Masuk dengan Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(270, 45),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 10),

              // Link daftar
              const Text('Belum punya akun ?'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.to(const Register()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    color: Color.fromARGB(255, 20, 216, 79),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(270, 45),
                ),
                child: const Text('Daftar Sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

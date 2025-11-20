import 'package:dailynutryapp/views/auth/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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

  // Fungsi login Firebase
  signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (!mounted) return;

      // Sync user ke Flask
      await syncUserToFlask();

      Navigator.pushReplacementNamed(context, '/beranda');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Login gagal')));
    }
  }

  // Fungsi sync ke Flask
  Future<void> syncUserToFlask() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final token = await user.getIdToken();

      final response = await http.post(
        Uri.parse("http://127.0.0.1:5000/api/sync-user"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"token": token, "email": user.email}),
      );

      if (response.statusCode == 200) {
        print("Sync ke Flask berhasil");
      } else {
        print("Sync ke Flask gagal: ${response.statusCode}");
      }
    } catch (e) {
      print("Gagal sync ke Flask: $e");
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
              const SizedBox(height: 50),

              // Judul
              Text("Masuk", style: GoogleFonts.roboto(fontSize: 50)),
              const SizedBox(height: 50),

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
              const SizedBox(height: 30),

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
              const SizedBox(height: 50),

              // Link daftar
              const Text('Belum punya akun ?'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.to(const Register()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color:Color.fromARGB(255, 20, 216, 79), width: 2),
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
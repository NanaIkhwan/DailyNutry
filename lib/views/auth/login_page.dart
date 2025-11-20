
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

  signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (!mounted) return; // ⬅️ Tambahkan ini

      // ⬅️ Tambahkan ini: Sync user ke Flask
      await syncUserToFlask();

      // print('login berhasil');
      Navigator.pushReplacementNamed(context, '/beranda');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return; // ⬅️ Tambahkan ini juga

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login gagal')));
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
              // Tambahkan animasi di sini
              Lottie.asset('images/welcome.json', height: 250),
              const SizedBox(height: 50),
              Text("Masuk", style: GoogleFonts.roboto(fontSize: 50)),
              const SizedBox(height: 50),
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
              TextField(
                controller: password,
                decoration: const InputDecoration(
                  label: Text("Masukkan Password"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 117, 236, 179),
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(270, 45),
                ),
                child: const Text("Masuk"),
              ),

              SizedBox(height: 50),

              Text('Belum punya akun ?'),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.to(const Register()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.greenAccent, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(270, 45),
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

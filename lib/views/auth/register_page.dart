import 'package:dailynutryapp/views/auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // simpan nama ke firebase auth
      await userCredential.user!.updateDisplayName(username.text.trim());

      Get.offAll(Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Gagal daftar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/images/RegisLeady.json', height: 250),
              const SizedBox(height: 30),

              Text(
                "Daftar",
                style: GoogleFonts.roboto(fontSize: 40),
              ),
              const SizedBox(height: 30),

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

              TextField(
                controller: username,
                decoration: const InputDecoration(
                  label: Text('Masukkan Username'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Masukkan Password"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 20, 216, 79),
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(270, 45),
                  ),
                  child: const Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
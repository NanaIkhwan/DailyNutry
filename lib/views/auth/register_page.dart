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
  TextEditingController password = TextEditingController();

  signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );

    Get.offAll(Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Lottie.asset('images/RegisLeady.json', height: 250),
            SizedBox(height: 50),
            Text("Daftar", style: GoogleFonts.roboto(fontSize: 50)),
            SizedBox(height: 50),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Masukkan Email'),
            ),
            SizedBox(height: 30),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: 'Masukkan Password'),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: (() => signUp()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 117, 236, 179),
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                minimumSize: Size(270, 45),
              ),
              child: Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}

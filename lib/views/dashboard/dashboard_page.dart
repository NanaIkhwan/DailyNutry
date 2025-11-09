import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130), // ✅ tambah tinggi AppBar
        child: AppBar(
          backgroundColor: Colors.greenAccent,
          elevation: 0,
          title: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // ✅ teks di tengah vertikal
            children: [
              const SizedBox(height: 10), // ✅ jarak dari atas
              Text(
                '${user!.email} 👋',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selamat datang kembali!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87, // ✅ ubah warna agar terlihat jelas
                ),
              ),
            ],
          ),
          actions: [
            IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
      ),
      body: const Center(child: Text('Isi halaman')),
    );
  }
}

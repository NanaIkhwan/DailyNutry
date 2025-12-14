import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'edit_profile_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  // Fungsi logout dari akun Firebase
  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/login'); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal logout: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // mengambil user aktif dari firebase

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil & Pengaturan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 216, 79), 
        automaticallyImplyLeading: false,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          // KARTU PROFIL USER

          Card(
            elevation: 2, // efek bayangan
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // sudut membulat
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // avatar/icon pengguna
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE8F5E9), 
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 20, 216, 79), 
                      size: 40,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Nama dan email user yang login
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? "Pengguna",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? "Tidak ada email", 
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 35),

          // JUDUL PENGATURAN

          const Text(
            "Pengaturan Akun",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(height: 10),

          // TOMBOL EDIT PROFIL

          ListTile(
            leading: const Icon(Icons.edit, color: Colors.green), // ikon edit
            title: const Text("Edit Profil"),
            onTap: () {
              // pindah ke halaman EditProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfilePage()),
              );
            },
          ),

          const Divider(),

          // TOMBOL LOGOUT

          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade400), 
            title: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _logout(context), // panggil fungsi logout
          ),
        ],
      ),
    );
  }
}

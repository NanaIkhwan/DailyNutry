import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil & Pengaturan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 167, 252, 219),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // tombol kembali ke halaman sebelumnya
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu profil sederhana
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE8F5E9),
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.green, size: 40),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hai ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "user@email.com",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Daftar menu pengaturan
          // _buildSettingItem(
          //   icon: Icons.dining,
          //   title: "Batas Konsumsi Harian",
          //   subtitle: "Atur batas maksimal konsumsi harian",
          // ),
          // _buildSettingItem(
          //   icon: Icons.notifications,
          //   title: "Notifikasi",
          //   subtitle: "Atur pemberitahuan aplikasi",
          // ),
          // _buildSettingItem(
          //   icon: Icons.info,
          //   title: "Tentang Aplikasi",
          //   subtitle: "Versi 1.0.0",
          // ),
          // _buildSettingItem(
          //   icon: Icons.help,
          //   title: "Bantuan & Dukungan",
          //   subtitle: "Hubungi kami",
          // ),
        ],
      ),
    );
  }

  // Widget menu pengaturan sederhana
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color.fromARGB(255, 167, 252, 219)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {}, // aksi nanti bisa ditambah
      ),
    );
  }
}

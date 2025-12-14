import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

// State dari EditProfilePage
class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>(); // key untuk validasi form
  final TextEditingController _nameController = TextEditingController(); // controller input nama

  bool _loading = false; // indikator loading tombol Simpan

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser; // ambil user login
    _nameController.text = user?.displayName ?? ""; // isi otomatis nama user
  }

  // Fungsi menyimpan perubahan profil
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return; // cek validasi form

    try {
      setState(() => _loading = true); // tampilkan loading

      final user = FirebaseAuth.instance.currentUser; // dapatkan user saat ini

      await user?.updateDisplayName(_nameController.text); // update nama
      await user?.reload(); // refresh data user

      setState(() => _loading = false); // stop loading

      // pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil berhasil diperbarui!")),
      );

      Navigator.pop(context); // kembali ke halaman sebelumnya

    } catch (e) {
      setState(() => _loading = false); // stop loading jika error

      // pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // ambil user login

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 20, 216, 79), 
      ),

      body: Padding(
        padding: const EdgeInsets.all(20), // padding halaman
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Ubah Informasi Profil",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 25), // jarak

            // Form edit profil
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // ==== FIELD NAMA ====
                  TextFormField(
                    controller: _nameController, // input nama
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      prefixIcon: const Icon(Icons.person, color: Colors.green), // ikon person
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12), // sudut input
                      ),
                    ),
                    validator: (value) { // validasi
                      if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // ==== FIELD EMAIL (READ ONLY) =====
                  TextFormField(
                    initialValue: user?.email ?? "", // email user
                    enabled: false, // tidak bisa diedit
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email), 
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey), 
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ====TOMBOL SIMPAN ====
                  SizedBox(
                    width: double.infinity, // full width button
                    child: ElevatedButton(
                      onPressed: _loading ? null : _saveProfile, // jika loading -> disable
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 216, 79),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // sudut button
                        ),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white) // loading spinner
                          : const Text(
                        "Simpan Perubahan",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

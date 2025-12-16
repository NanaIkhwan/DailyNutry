import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _nameController.text = user?.displayName ?? "";
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _loading = true);

      final user = FirebaseAuth.instance.currentUser;

      await user?.updateDisplayName(_nameController.text);
      await user?.reload();

      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil berhasil diperbarui!")),
      );

      Navigator.pop(context); // kembali ke ProfilPage

    } catch (e) {
      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 20, 216, 79),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
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

            const SizedBox(height: 25),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // 🔹 FIELD NAMA
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      prefixIcon: const Icon(Icons.person, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // 🔹 TAMPILKAN EMAIL
                  TextFormField(
                    initialValue: user?.email ?? "",
                    enabled: false,
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

                  // 🔹 Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 216, 79),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
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
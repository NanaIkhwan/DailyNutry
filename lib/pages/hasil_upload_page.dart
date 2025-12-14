import 'dart:io'; // untuk akses file lokal (gambar)
import 'package:flutter/material.dart'; // library UI Flutter

// Halaman untuk menampilkan hasil upload gambar
class HasilUploadPage extends StatelessWidget {
  final String imagePath; // lokasi file gambar yang di-upload user

  const HasilUploadPage({
    Key? key,
    required this.imagePath, // parameter wajib
  }) : super(key: key);

  // Widget untuk membuat bulatan warna (indikator)
  Widget warnaBulatan(Color warna) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: warna, // warna bulatan
        shape: BoxShape.circle, // bentuk lingkaran
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // warna latar belakang halaman
      body: SafeArea(
        child: SingleChildScrollView( // biar bisa discroll ke bawah
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==== HEADER =====
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 20, 216, 79), // warna header hijau
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context), // kembali ke halaman sebelumnya
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Hasil Upload",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==== GAMBAR ====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1), // background abu
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(imagePath), // gambar yang di-upload
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover, // memenuhi container
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ================== KATEGORI WARNA ==================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    warnaBulatan(Colors.green), // indikator alami
                    const SizedBox(width: 6),
                    const Text("Alami"),

                    const SizedBox(width: 20),
                    warnaBulatan(Colors.yellow), // indikator campuran
                    const SizedBox(width: 6),
                    const Text("Campuran"),

                    const SizedBox(width: 20),
                    warnaBulatan(Colors.red), // indikator sintetis
                    const SizedBox(width: 6),
                    const Text("Sintetis"),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ==== JUDUL ANALISIS ====
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Analisis Komposisi",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================== ITEM ANALISIS CONTROLLER ==================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    warnaBulatan(Colors.green), // kategori 'Alami'
                    const SizedBox(width: 10),
                    const Text(
                      "Gula", // nama komposisi
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Detail dari komposisi
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kegunaan : Bahan utama pembentuk makanan."), // penjelasan singkat
                    SizedBox(height: 6),
                    Text("Batas Wajar : Maksimal 50 gr per hari"), // batas aman
                    SizedBox(height: 6),
                    Text(
                      "Dampak : Jika berlebihan maka akan beresiko terkena diabetes.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ==== DAFTAR BAHAN TAMBAHAN =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        warnaBulatan(Colors.green), // kategori alami
                        const SizedBox(width: 8),
                        const Text("Garam"),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        warnaBulatan(Colors.yellow), // kategori campuran
                        const SizedBox(width: 8),
                        const Text("Tartazine"),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        warnaBulatan(Colors.yellow), // kategori campuran
                        const SizedBox(width: 8),
                        const Text("Natrium Benzoat"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ==== BUTTON SIMPAN ====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {}, // aksi ketika tombol ditekan
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14D84F), // warna tombol hijau
                      foregroundColor: Colors.white, // warna teks
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // sudut tombol
                      ),
                    ),
                    child: const Text(
                      "Simpan Analisis", // teks tombol
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

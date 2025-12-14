import 'package:flutter/material.dart';
import 'beranda_page.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> dataEdukasi = [
      {
        'kategori': 'Kesehatan', 
        'judul': 'Kurangi Gula dan Lemak',
        'isi':
            'Konsumsi gula dan lemak berlebih dapat meningkatkan risiko penyakit jantung.', 
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edukasi', style: TextStyle(color: Colors.white)), 
        backgroundColor: const Color.fromARGB(255, 20, 216, 79), 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // ikon kembali
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BerandaPage()), // kembali ke beranda
            );
          },
        ),
      ),

      // Daftar edukasi menggunakan ListView
      body: ListView.builder(
        padding: const EdgeInsets.all(16), // jarak tepi
        itemCount: dataEdukasi.length, // jumlah item
        itemBuilder: (context, index) {
          final item = dataEdukasi[index]; 
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // sudut kartu
            ),
            elevation: 2, // efek shadow
            margin: const EdgeInsets.only(bottom: 12), // jarak antar kartu

            child: Padding(
              padding: const EdgeInsets.all(16), // padding dalam kartu
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Ikon buku di kiri
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100, // warna background ikon
                      borderRadius: BorderRadius.circular(12), // sudut kotak ikon
                    ),
                    child: const Icon(
                      Icons.book, // ikon buku
                      color: Color.fromARGB(255, 20, 216, 79), 
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 12), // jarak antar ikon dan teks

                  // Bagian teks (kategori, judul, isi)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // kategori
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50, 
                            borderRadius: BorderRadius.circular(6), // sudut badge
                          ),
                          child: Text(
                            item['kategori']!, 
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 20, 216, 79),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Judul edukasi
                        Text(
                          item['judul']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Isi edukasi
                        Text(
                          item['isi']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

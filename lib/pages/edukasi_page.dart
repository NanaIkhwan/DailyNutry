import 'package:flutter/material.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dataEdukasi = [
      // {
      //   'kategori': 'Gizi',
      //   'judul': 'Pentingnya Membaca Label Gizi',
      //   'isi':
      //       'Label gizi membantu kita mengetahui kandungan makanan sebelum dikonsumsi.',
      // },
      // {
      //   'kategori': 'Keamanan Pangan',
      //   'judul': 'Cek Tanggal Kedaluwarsa',
      //   'isi':
      //       'Pastikan produk makanan tidak melewati tanggal kedaluwarsa sebelum dibeli.',
      // },
      // {
      //   'kategori': 'Kesehatan',
      //   'judul': 'Kurangi Gula dan Lemak',
      //   'isi':
      //       'Konsumsi gula dan lemak berlebih dapat meningkatkan risiko penyakit jantung.',
      // },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edukasi', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4CAF50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // tombol kembali
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dataEdukasi.length,
        itemBuilder: (context, index) {
          final item = dataEdukasi[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.book,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['kategori']!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['judul']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
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

import 'package:flutter/material.dart';
import 'beranda_page.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> riwayat = [
      {'produk': 'Air Mineral', 'tanggal': '8 Nov 2025', 'status': ''},
      {
        'produk': 'Minuman Bersoda',
        'tanggal': '6 Nov 2025',
        'status': '',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Pemeriksaan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 20, 216, 79),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BerandaPage()),
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: riwayat.length,
        itemBuilder: (context, index) {
          final item = riwayat[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 2,
            child: ListTile(
              title: Text(
                item['produk']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['tanggal']!),
              trailing: const SizedBox.shrink(), // <-- status dihilangkan total
            ),
          );
        },
      ),
    );
  }

  // Tetap dipertahankan untuk menjaga struktur dasar (tidak digunakan lagi)
  // Color _getStatusColor(String status) {
  //   if (status == 'Aman') return Colors.green;
  //   if (status == 'Waspada') return Colors.orange;
  //   if (status == 'Bahaya') return Colors.red;
  //   return Colors.grey;
  // }
}

import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> riwayat = [
      // {'produk': 'Air Mineral', 'tanggal': '8 Nov 2025', 'status': 'Aman'},
      // {'produk': 'Keripik Pedas', 'tanggal': '7 Nov 2025', 'status': 'Waspada'},
      // {
      //   'produk': 'Minuman Bersoda',
      //   'tanggal': '6 Nov 2025',
      //   'status': 'Bahaya',
      // },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Pemeriksaan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 167, 252, 219),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(item['status']!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item['status']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'Aman') return Colors.green;
    if (status == 'Waspada') return Colors.orange;
    if (status == 'Bahaya') return Colors.red;
    return Colors.grey;
  }
}

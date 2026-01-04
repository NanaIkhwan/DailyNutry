import 'package:flutter/material.dart';
import 'beranda_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  bool isLoading = true;
  List<dynamic> riwayat = [];

  Future<void> fetchRiwayat() async {
    final url = Uri.parse(
      "https://june-chattable-tora.ngrok-free.dev/analysis/history",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          riwayat = data["data"];
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRiwayat();
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
              title: const Text(
                "Hasil Scan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item["created_at"] ?? "-"),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Gula: ${item["sugar"]} g"),
                  Text("Garam: ${item["salt"]} g"),
                  Text("Lemak: ${item["fat"]} g"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
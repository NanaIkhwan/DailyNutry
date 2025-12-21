import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HasilUploadPage extends StatefulWidget {
  final String imagePath;

  const HasilUploadPage({super.key, required this.imagePath});

  @override
  State<HasilUploadPage> createState() => _HasilUploadPageState();
}

class _HasilUploadPageState extends State<HasilUploadPage> {
  String? ocrText;
  bool isLoading = true;
  List<dynamic> classifiedResults = [];

  List<String> parseIngredients(String text) {
    return text
        .toLowerCase()
        .split(RegExp(r'[,\n]')) // pisah koma & enter
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  Future<void> _sendToServer() async {
    final url = Uri.parse(
      "https://june-chattable-tora.ngrok-free.dev/analysis/ocr",
    );

    var request = http.MultipartRequest("POST", url);
    request.files.add(
      await http.MultipartFile.fromPath("image", widget.imagePath),
    );

    try {
      final response = await request.send();
      final result = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = json.decode(result);
        final text = data["extracted_text"];

        // PARSE BAHAN
        final ingredients = List<String>.from(data["ingredients"]);

        // PANGGIL KLASIFIKASI
        final classified = await classifyIngredients(ingredients);

        // DEBUG PRINT
        print("OCR: $text");
        print("CLASSIFIED: $classified");

        setState(() {
          ocrText = text;
          classifiedResults = classified;
          isLoading = false;
        });
      } else {
        setState(() {
          ocrText = "Terjadi kesalahan server.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        ocrText = "Gagal terhubung ke server: $e";
        isLoading = false;
      });
    }
  }

  Future<List<dynamic>> classifyIngredients(List<String> ingredients) async {
    final url = Uri.parse(
      "https://june-chattable-tora.ngrok-free.dev/analysis/classify",
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"ingredients": ingredients}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["results"];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _sendToServer();
  }

  Widget warnaBulatan(Color warna) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(color: warna, shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 20, 216, 79),
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
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Hasil Upload",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // GAMBAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(widget.imagePath),
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // KATEGORI WARNA
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: classifiedResults.map((item) {
                    final isAlami = item["category"] == "alami";

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          warnaBulatan(
                            isAlami ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            item["ingredient"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 25),

              // ANALISIS
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Analisis Komposisi",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              /// ======== CONTOH KOMPONEN ========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    warnaBulatan(Colors.green),
                    const SizedBox(width: 10),
                    const Text(
                      "Gula",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kegunaan : Bahan utama pembentuk makanan."),
                    SizedBox(height: 6),
                    Text("Batas Wajar : Maksimal 50 gr per hari"),
                    SizedBox(height: 6),
                    Text(
                      "Dampak : Jika berlebihan maka akan beresiko terkena diabetes.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// DAFTAR TAMBAHAN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        warnaBulatan(Colors.green),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        warnaBulatan(Colors.red),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        warnaBulatan(Colors.red),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // BUTTON SIMPAN
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14D84F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Simpan Analisis",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
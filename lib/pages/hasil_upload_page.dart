import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HasilUploadPage extends StatefulWidget {
  final String imagePath;

  const HasilUploadPage({super.key, required this.imagePath});

  @override
  State<HasilUploadPage> createState() => _HasilUploadPageState();
}

class _HasilUploadPageState extends State<HasilUploadPage> {
  bool isLoading = true;
  List<dynamic> classifiedResults = [];

  // ================== API ==================
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
        setState(() {
          classifiedResults = data["results"] ?? [];
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
    _sendToServer();
  }

  // ================== WIDGET ==================
  Widget warnaBulatan(Color warna) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: warna,
        shape: BoxShape.circle,
      ),
    );
  }

  // ================== ACCORDION ITEM ==================
  Widget itemBahanAccordion(Map item) {
    final bool isAlami = item["category"] == "alami";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        leading: warnaBulatan(isAlami ? Colors.green : Colors.red),

        title: Text(
          item["ingredient"] ?? "-",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        children: [
          Text("Kegunaan : ${item["informasi_kegunaan"] ?? "-"}"),
          const SizedBox(height: 6),
          Text("Batas Wajar : ${item["batas_wajar"] ?? "-"}"),
          const SizedBox(height: 6),
          Text("Dampak : ${item["dampak_negatif"] ?? "-"}"),
        ],
      ),
    );
  }

  // ================== UI ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== HEADER =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF14D84F),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
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
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== GAMBAR =====
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

              const SizedBox(height: 20),

              // ===== HASIL OCR (ACCORDION) =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: classifiedResults
                      .map((item) => itemBahanAccordion(item))
                      .toList(),
                ),
              ),

              const SizedBox(height: 30),

              // ===== BUTTON =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14D84F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Simpan Analisis",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

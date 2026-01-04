import 'dart:convert';
import 'package:http/http.dart' as http;

class AnalysisService {
  static const baseUrl = "https://june-chattable-tora.ngrok-free.dev";

  static Future<Map<String, dynamic>> uploadImage(String imagePath) async {
    final url = Uri.parse("$baseUrl/analysis/ocr");
    var request = http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromPath("image", imagePath));

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception("Gagal upload OCR");
    }

    return json.decode(body);
  }

  static Future<void> saveAnalysis({
    required int uploadId,
    required double sugar,
    required double saltGram,
    required double fat,
  }) async {
    final url = Uri.parse("$baseUrl/analysis/save");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "upload_id": uploadId,
        "sugar": sugar,
        "salt": saltGram,
        "fat": fat,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal simpan analisis");
    }
  }
}
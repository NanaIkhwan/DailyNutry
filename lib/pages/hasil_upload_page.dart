import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dailynutryapp/services/analysis_service.dart';
import 'package:dailynutryapp/utils/pengubah_nutrisi.dart';

import '../widgets/ingredient_accordion.dart';
import '../widgets/input_nutrisi.dart';

class HasilUploadPage extends StatefulWidget {
  final String imagePath;

  const HasilUploadPage({
    super.key,
    required this.imagePath,
  });

  @override
  State<HasilUploadPage> createState() => _HasilUploadPageState();
}

class _HasilUploadPageState extends State<HasilUploadPage> {
  bool isLoading = true;
  List<dynamic> classifiedResults = [];
  int? uploadId;

  final gulaController = TextEditingController();
  final garamController = TextEditingController();
  final lemakController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _uploadImage();
  }

  Future<void> _uploadImage() async {
    try {
      final data = await AnalysisService.uploadImage(widget.imagePath);

      setState(() {
        classifiedResults = data["results"] ?? [];
        uploadId = data["upload_id"];
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal upload OCR: $e")),
        );
      }
    }
  }

  Future<void> _saveAnalysis() async {
    if (uploadId == null) return;

    final sugar = double.tryParse(gulaController.text) ?? 0;
    final saltMg = double.tryParse(garamController.text) ?? 0;
    final fat = double.tryParse(lemakController.text) ?? 0;

    try {
      await AnalysisService.saveAnalysis(
        uploadId: uploadId!,
        sugar: sugar,
        saltGram: mgToGram(saltMg),
        fat: fat,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Analisis berhasil disimpan")),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal simpan: $e")),
        );
      }
    }
  }

  @override
  void dispose() {
    gulaController.dispose();
    garamController.dispose();
    lemakController.dispose();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // ⬅️ INI PENTING UNTUK HILANGKAN OVERFLOW
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              const SizedBox(height: 20),
              _imagePreview(),
              const SizedBox(height: 20),
              _resultSection(),
              const SizedBox(height: 24),
              _nutritionInputSection(),
              const SizedBox(height: 24),
              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _header(BuildContext context) {
    return Container(
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
    );
  }

  // ================= IMAGE =================

  Widget _imagePreview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(widget.imagePath),
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ================= RESULT =================

  Widget _resultSection() {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (classifiedResults.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text("Tidak ada bahan terdeteksi")),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: classifiedResults
            .map((item) => IngredientAccordion(item: item))
            .toList(),
      ),
    );
  }

  // ================= INPUT NUTRISI =================

  Widget _nutritionInputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NutritionInput(
            label: "Gula (gram)",
            controller: gulaController,
          ),
          const SizedBox(height: 12),
          NutritionInput(
            label: "Garam (mg)",
            controller: garamController,
          ),
          const SizedBox(height: 12),
          NutritionInput(
            label: "Lemak (gram)",
            controller: lemakController,
          ),
        ],
      ),
    );
  }

  // ================= BUTTON =================

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _saveAnalysis,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _submitPhoto() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a photo first')),
      );
      return;
    }

    // Implement your upload logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Photo submitted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2ECC71),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upload',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Upload a photo of yourself\nholding your valid',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            // Upload area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    
                    // Upload box
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 240,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: _selectedImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.cloud_upload,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Tap to upload photo',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'PNG or JPG (max 5mb)',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black54,
                                        child: IconButton(
                                          icon: const Icon(Icons.close, color: Colors.white),
                                          onPressed: () {
                                            setState(() {
                                              _selectedImage = null;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _submitPhoto,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2ECC71),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom navigation
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2ECC71),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Beranda', false),
                  _buildNavItem(Icons.notifications_outlined, 'Notifikasi', false),
                  _buildNavItem(Icons.person_outline, 'Profil', true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
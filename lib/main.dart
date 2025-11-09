import 'package:flutter/material.dart';
import 'pages/beranda_page.dart';
import 'pages/chatbotpage.dart';
import 'upload_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Nutri App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      // Awal aplikasi tetap ke beranda_page
      home: const BerandaPage(),
      // Tapi bisa navigasi ke UploadPage kalau dibutuhkan
      routes: {
        '/upload': (context) => const UploadPage(),
        '/chatbot': (context) => const ChatbotPage(),
      },
    );
  }
}

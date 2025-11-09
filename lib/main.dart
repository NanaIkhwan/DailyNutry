import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'pages/beranda_page.dart';
import 'pages/chatbotpage.dart';

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
      home: const BerandaPage(),
    );
  }
}
=======
import 'upload_page.dart';

void main() {
  runApp(const MaterialApp(
    home: UploadPage(),
    debugShowCheckedModeBanner: false,
  ));
}
>>>>>>> origin/feature/upload

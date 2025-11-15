import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import halaman fitur
import 'views/splash/splash_screen.dart'; // Splash dari branch kamu
import 'pages/beranda_page.dart'; // Beranda dari full_project
import 'pages/chatbotpage.dart'; // Chatbot
import 'upload_page.dart'; // Upload Page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Nutri App',

      // Tema dari full_project (ini penting, jangan dihapus)
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),

      // Halaman awal aplikasi (punya kamu)
      home: const SplashScreenWidget(),

      // Routing lengkap
      routes: {
        '/home': (context) => const BerandaPage(),
        '/beranda': (context) => const BerandaPage(),
        '/upload': (context) => const UploadPage(),
        '/chatbot': (context) => const ChatbotPage(),
      },
    );
  }
}

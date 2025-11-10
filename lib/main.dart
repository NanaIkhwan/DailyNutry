// import 'package:dailynutryapp/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Halaman utama dari project kamu
import 'pages/beranda_page.dart';
import 'pages/chatbotpage.dart';
import 'upload_page.dart';

// Halaman splash dari feature/login
import 'views/splash/splash_screen.dart';

void main() async {
  // Pastikan Flutter dan Firebase sudah siap sebelum runApp
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

      // Tema utama aplikasi
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),

      // Halaman pertama yang muncul (Splash Screen)
      home: const SplashScreenWidget(),

      // Route ke halaman lain
      routes: {
        '/home': (context) => const BerandaPage(),
        '/beranda': (context) => const BerandaPage(),
        '/upload': (context) => const UploadPage(),
        '/chatbot': (context) => const ChatbotPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dailynutryapp/pages/feedback_page.dart';


// Halaman utama dari project kamu
import 'pages/beranda_page.dart';
import 'pages/chatbotpage.dart';
import 'upload_page.dart';

// Halaman splash dan login
import 'views/splash/splash_screen.dart';
import 'views/auth/login_page.dart'; //  sesuai struktur folder kamu

void main() async {
  // Pastikan Flutter dan Firebase siap
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

      // Tema aplikasi
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),

      // Halaman pertama (SplashScreen)
      home: const SplashScreenWidget(),

      // Semua route aplikasi
      routes: {
        '/home': (context) => const BerandaPage(),
        '/beranda': (context) => const BerandaPage(),
        '/upload': (context) => const UploadPage(),
        '/chatbot': (context) => const ChatbotPage(),
        '/feedback': (context) => const FeedbackPage(),
        '/login': (context) => const Login(), // penting untuk logout
      },
    );
  }
}

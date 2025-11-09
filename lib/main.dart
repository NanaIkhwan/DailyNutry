// import 'package:dailynutryapp/views/auth/login_page.dart';
// import 'package:dailynutryapp/views/dashboard/dashboard_page.dart';
// import 'package:dailynutryapp/views/dashboard/dashboard_page.dart';
import 'package:dailynutryapp/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'pages/beranda_page.dart';
import 'pages/chatbotpage.dart';
import 'upload_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DailyNutryApp',
      home: SplashScreenWidget(),
      // routes: {
      //   '/home' : (context) => HomePage()
      // },
      // home: SplashScreen(),
>>>>>>> origin/feature/login
    );
  }
}

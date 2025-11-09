import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:dailynutryapp/views/auth/login_page.dart';
import 'package:dailynutryapp/views/auth/wrapper.dart';
// import 'package:dailynutryapp/views/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gunakan Flexible agar tetap menyesuaikan layar tanpa overflow
            Flexible(
              flex: 5,
              child: Lottie.asset(
                'assets/images/List Food.json',
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // jarak kecil antar elemen
            Flexible(
              flex: 1,
              child: Text(
                "DailyNutry",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      nextScreen: const Wrapper(),
      splashIconSize: 450, // biarkan cukup besar, tapi masih muat di layar
      duration: 5000,
      backgroundColor: const Color.fromARGB(255, 167, 252, 219),
    );
  }
}

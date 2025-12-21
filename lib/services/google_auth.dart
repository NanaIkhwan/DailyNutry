import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class GoogleAuthService {
  // Inisialisasi instance Firebase Auth dan Google Sign-In
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final logger = Logger();

  /// Metode untuk melakukan Sign-In menggunakan Google dan mengautentikasi ke Firebase.
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Memulai proses Sign-In Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Cek jika pengguna membatalkan proses sign-in
      if (googleUser == null) {
        logger.i('Google Sign-In dibatalkan oleh pengguna.');
        return null;
      }

      // 2. Mendapatkan token autentikasi dari Google
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // 3. Membuat AuthCredential untuk Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign-In ke Firebase menggunakan Credential
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      // Mengembalikan objek User yang berhasil sign-in
      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      // Penanganan error spesifik dari Firebase Auth
      logger.i('Firebase Auth Error saat Sign-In Google: ${e.code} - ${e.message}');
      // Contoh: 'account-exists-with-different-credential'
      return null;
    } catch (e) {
      // Penanganan error umum (misalnya masalah koneksi)
      logger.i('Error umum saat Sign-In Google: $e');
      return null;
    }
  }

  // ---

  /// Metode untuk melakukan Sign-Out dari Google dan Firebase.
  Future<void> signOutGoogleAndFirebase() async {
    try {
      // 1. Sign-Out dari Google
      await _googleSignIn.signOut();
      logger.i('Berhasil Sign-Out dari Google.');

      // 2. Sign-Out dari Firebase Auth
      await _auth.signOut();
      logger.i('Berhasil Sign-Out dari Firebase.');

    } on FirebaseAuthException catch (e) {
      logger.i('Firebase Auth Error saat Sign-Out: ${e.code} - ${e.message}');
      // Anda mungkin ingin melempar ulang error ini atau menampilkannya ke user
    } catch (e) {
      logger.i('Error umum saat Sign-Out: $e');
    }
  }
}
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🌿 AppBar khas DailyNutri
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 216, 79),
        elevation: 0,
        title: const Text(
          "Feedback Pengguna",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // 🌿 Isi halaman
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Beri Masukan untuk Aplikasi",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Kami sangat menghargai saran dan masukan Anda untuk meningkatkan kualitas aplikasi DailyNutri.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // ⭐ TextField Feedback
            TextField(
              controller: _feedbackController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Tulis feedback Anda di sini...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ⭐ Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_feedbackController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Feedback masih kosong!")));
                    return;
                  }

                  // Nanti bisa dihubungkan ke Firebase/Database
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Terima kasih atas feedback Anda!")),
                  );

                  _feedbackController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 20, 216, 79),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Kirim Feedback",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

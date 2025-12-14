import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController(); // kontrol input teks
  final List<Map<String, String>> _messages = []; // menyimpan chat (user + bot)

  // Fungsi balasan chatbot (dummy sementara)
  String _botReply(String userMessage) {
    userMessage = userMessage.toLowerCase(); // ubah ke huruf kecil agar lebih mudah dicari

    // == Logika jawaban sederhana ==
    if (userMessage.contains("gula")) {
      return "Konsumsi gula berlebih berisiko diabetes. Batas harian: 50g. Coba kurangi minuman manis ya! 🍬";
    }
    if (userMessage.contains("garam")) {
      return "Batas konsumsi garam harian adalah 6g. Terlalu banyak bisa meningkatkan tekanan darah. 🧂";
    }
    if (userMessage.contains("lemak")) {
      return "Lemak baik diperlukan tubuh, tapi lemak jenuh harus dibatasi. Batas harian ±70g. 🍟";
    }
    if (userMessage.contains("aman") || userMessage.contains("makanan")) {
      return "Untuk mengetahui keamanan makanan, silakan gunakan fitur Upload Foto. Saya bisa bantu menjelaskan kandungannya! 🍽️";
    }

    // default jika tidak ada kecocokan kata
    return "Baik, saya bantu! Coba tanyakan tentang gula, garam, lemak, atau nutrisi harian. 😊";
  }

  // Mengirim pesan
  void _sendMessage() {
    if (_controller.text.isEmpty) return; // jika kosong, tidak dikirim

    String userMsg = _controller.text; // ambil teks user

    setState(() {
      _messages.add({"sender": "user", "text": userMsg}); // simpan chat user
      _messages.add({"sender": "bot", "text": _botReply(userMsg)}); // simpan balasan bot
    });

    _controller.clear(); // hapus textfield
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDF8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Daily Nutri Chatbot"), // judul halaman
      ),

      body: Column(
        children: [
          // ==== AREA CHAT LIST =====
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length, // jumlah chat
              itemBuilder: (context, index) {
                bool isUser = _messages[index]["sender"] == "user"; // cek pengirim

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft, // posisi bubble
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 250), // batas lebar pesan
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green : Colors.white, // warna bubble
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        )
                      ],
                    ),
                    child: Text(
                      _messages[index]["text"]!, // isi pesan
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87, // warna teks
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ===== INPUT AREA =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -1)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // mengontrol text input
                    decoration: InputDecoration(
                      hintText: "Tanya tentang nutrisi...", // placeholder input
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), // bentuk input oval
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // TOMBOL KIRIM PESAN
                InkWell(
                  onTap: _sendMessage, // kirim chat
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle, // tombol bulat
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

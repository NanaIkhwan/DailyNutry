import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // 🔹 Dummy chatbot, nanti bisa diganti AI beneran
  String _botReply(String userMessage) {
    userMessage = userMessage.toLowerCase();

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
      return "Untuk mengetahui keamanan makanan, silakan gunakan fitur Upload Foto di Daily Nutri. Saya bisa bantu menjelaskan kandungan nutrisinya! 🍽️";
    }

    return "Baik, saya bantu! Coba tanyakan tentang gula, garam, lemak, keamanan makanan, atau nutrisi harian. 😊";
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    String userMsg = _controller.text;

    setState(() {
      _messages.add({"sender": "user", "text": userMsg});
      _messages.add({"sender": "bot", "text": _botReply(userMsg)});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDF8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Daily Nutri Chatbot"),
      ),

      body: Column(
        children: [
          // ================= CHAT AREA =================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isUser = _messages[index]["sender"] == "user";

                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green : Colors.white,
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
                      _messages[index]["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ================= INPUT AREA =================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -1))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Tanya tentang nutrisi...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // SEND BUTTON
                InkWell(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
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

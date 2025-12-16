import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  Future<String> _sendToChatbotAPI(String message) async {
    final url = Uri.parse("https://june-chattable-tora.ngrok-free.dev/chatbot");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["reply"];
      } else {
        return "Server error (${response.statusCode})";
      }
    } catch (e) {
      return "Gagal terhubung ke server";
    }
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMsg = _controller.text;

    setState(() {
      _messages.add({"sender": "user", "text": userMsg});
      _messages.add({"sender": "bot", "text": "Mengetik..."});
    });

    _controller.clear();

    final reply = await _sendToChatbotAPI(userMsg);

    setState(() {
      _messages.removeLast(); // hapus "Mengetik..."
      _messages.add({"sender": "bot", "text": reply});
    });
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
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
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
                        ),
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
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -1),
                ),
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

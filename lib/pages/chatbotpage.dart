import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Chatbot'),
        backgroundColor: const Color.fromARGB(255, 20, 216, 79),
      ),
      body: const Center(child: Text('Ini halaman chatbot')),
    );
  }
}

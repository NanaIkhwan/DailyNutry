import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Chatbot'),
        backgroundColor: Colors.green,
      ),
      body: const Center(child: Text('Ini halaman chatbot')),
    );
  }
}

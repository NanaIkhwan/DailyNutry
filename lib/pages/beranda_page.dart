import 'package:flutter/material.dart';
import 'chatbotpage.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHome(),

      // Tombol Chatbot di pojok kanan bawah
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatbotPage()),
          );
        },
        child: Icon(Icons.chat),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          // hanya tombol beranda yang aktif
          if (i == 0) setState(() => _index = i);
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Edukasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Column(
      children: [
        // Header bagian atas
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade400, Colors.green],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hai Sayang",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Pilih makanan yang aman",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Cari produk...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Bagian konsumsi harian
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                "Konsumsi Harian Anda",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              _buildCardKonsumsi(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardKonsumsi() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _buildItem("Gula", 15, 50, Colors.green),
            SizedBox(height: 16),
            _buildItem("Garam", 4, 6, Colors.orange),
            SizedBox(height: 16),
            _buildItem("Lemak", 45, 70, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String nama, int sekarang, int max, Color warna) {
    double persen = (sekarang / max).clamp(0, 1);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nama, style: TextStyle(fontWeight: FontWeight.w600)),
            Text("$sekarang/$max g", style: TextStyle(color: Colors.grey)),
          ],
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: persen,
          color: warna,
          backgroundColor: Colors.grey[200],
          minHeight: 10,
        ),
      ],
    );
  }
}

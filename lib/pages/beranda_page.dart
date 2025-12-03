import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

import 'chatbotpage.dart';
import 'riwayat_page.dart';
import 'package:dailynutryapp/upload_page.dart';
import 'edukasi_page.dart';
// import 'profil_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _index = 0;

  final List<Widget> _pages = [
    const BerandaUtama(),
    const RiwayatPage(),
    const UploadPage(),
    const EdukasiPage(),
    // const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 20, 216, 79),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatbotPage()),
          );
        },
        child: const Icon(Icons.chat, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadPage()),
            );
          } else {
            setState(() {
              _index = i;
            });
          }
        },
        selectedItemColor: const Color.fromARGB(255, 20, 216, 79),
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
}

// =========================================================
//                    BERANDA UTAMA
// =========================================================

class BerandaUtama extends StatefulWidget {
  const BerandaUtama({super.key});

  @override
  State<BerandaUtama> createState() => _BerandaUtamaState();
}

class _BerandaUtamaState extends State<BerandaUtama> {
  // ======== Generate tanggal 7 hari terakhir =========
  late List<String> tanggalMinggu;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    tanggalMinggu = List.generate(
      7,
          (i) => "${now.subtract(Duration(days: 6 - i)).day}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ================= HEADER ===============
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 20, 216, 79),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------ Sapaan -------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hallo, ${FirebaseAuth.instance.currentUser?.displayName ?? 'User'} 👋",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Pilih makanan yang aman",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications,
                          color: Colors.white, size: 28),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Belum ada notifikasi")),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ------------------ Search --------------------
                TextField(
                  decoration: InputDecoration(
                    hintText: "Cari produk...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
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

        // ================= ISI KONTEN ===============
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ------------------ KONSUMSI HARIAN ------------------
              const Text(
                "Konsumsi Harian Anda",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildCardKonsumsi(),

              const SizedBox(height: 30),

              // ------------------ KONSUMSI MINGGUAN ------------------
              const Text(
                "Konsumsi Mingguan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 260,
                child: LineChart(
                  LineChartData(
                    minX: 1,
                    maxX: 7,
                    minY: 0,
                    maxY: 100,
                    gridData: FlGridData(show: false),

                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            if (value % 1 == 0) {
                              int index = value.toInt() - 1;
                              if (index >= 0 && index < tanggalMinggu.length) {
                                return Text(tanggalMinggu[index]);
                              }
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),

                    borderData: FlBorderData(show: false),

                    lineBarsData: [
                      // Gula
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        spots: const [
                          FlSpot(1, 40),
                          FlSpot(2, 60),
                          FlSpot(3, 45),
                          FlSpot(4, 80),
                          FlSpot(5, 70),
                          FlSpot(6, 50),
                          FlSpot(7, 60),
                        ],
                      ),

                      // Garam
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.orange,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        spots: const [
                          FlSpot(1, 20),
                          FlSpot(2, 35),
                          FlSpot(3, 25),
                          FlSpot(4, 40),
                          FlSpot(5, 45),
                          FlSpot(6, 30),
                          FlSpot(7, 25),
                        ],
                      ),

                      // Lemak
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.red,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        spots: const [
                          FlSpot(1, 55),
                          FlSpot(2, 70),
                          FlSpot(3, 65),
                          FlSpot(4, 90),
                          FlSpot(5, 85),
                          FlSpot(6, 60),
                          FlSpot(7, 78),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= CARD KONSUMSI HARIAN ===============
  Widget _buildCardKonsumsi() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildItem("Gula", 15, 50, Colors.blue),
            const SizedBox(height: 16),
            _buildItem("Garam", 4, 6, Colors.orange),
            const SizedBox(height: 16),
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
            Text(nama, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              "$sekarang/$max g",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
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

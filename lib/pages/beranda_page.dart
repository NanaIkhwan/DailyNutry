import 'package:flutter/material.dart';       
import 'package:firebase_auth/firebase_auth.dart';   
import 'package:fl_chart/fl_chart.dart';      

import 'chatbotpage.dart';     
import 'riwayat_page.dart';   
import 'package:dailynutryapp/upload_page.dart';  
import 'edukasi_page.dart';   
import 'profil_page.dart';  
class BerandaPage extends StatefulWidget { 
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _index = 0;  
  final List<Widget> _pages = [  // Daftar halaman bottom bar
    const BerandaUtama(),
    const RiwayatPage(),
    const UploadPage(),
    const EdukasiPage(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],  

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 20, 216, 79),
        onPressed: () {
          Navigator.push( // Pindah ke halaman chatbot
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
          if (i == 2) {  // Jika tab Upload ditekan, buka halaman Upload
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
        selectedItemColor: const Color.fromARGB(255, 20, 216, 79), // Warna tab aktif
        unselectedItemColor: Colors.grey,                         // Warna tab tidak aktif
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

class BerandaUtama extends StatefulWidget {     // Stateful karena grafik & tanggal berubah
  const BerandaUtama({super.key});

  @override
  State<BerandaUtama> createState() => _BerandaUtamaState();
}

class _BerandaUtamaState extends State<BerandaUtama> {
  // == Generate tanggal 7 hari terakhir ==
  late List<String> tanggalMinggu;   // Menyimpan tanggal untuk grafik mingguan

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();   // Tanggal sekarang
    tanggalMinggu = List.generate(
      7,   // Total 7 hari
      (i) => "${now.subtract(Duration(days: 6 - i)).day}", 
           // Mengambil hari (format angka)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // == HEADER ==
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
                // Sapaan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hallo, ${FirebaseAuth.instance.currentUser?.displayName ?? 'User'} 👋",
                          // Menampilkan nama dari akun Firebase
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

                //  Search Bar
              ],
            ),
          ),
        ),

        // == ISI KONTEN ==
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Konsumsi Harian Anda",    
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildCardKonsumsi(),       

              const SizedBox(height: 30),
 
              const Text(
                "Konsumsi Mingguan",     
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 260,  // Tinggi grafik
                child: LineChart(
                  LineChartData(
                    minX: 1,
                    maxX: 7,
                    minY: 0,
                    maxY: 100,  // Rentang nilai grafik
                    gridData: FlGridData(show: false),  // Grid tidak ditampilkan

                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,  // Menampilkan judul sumbu X
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            // Menampilkan tanggal 7 hari
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
                        sideTitles: SideTitles(showTitles: false),  // Sumbu Y kiri disembunyikan
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),  // Sumbu Y kanan disembunyikan
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),  // Sumbu atas disembunyikan
                      ),
                    ),

                    borderData: FlBorderData(show: false), // Border grafik dihapus

                    lineBarsData: [
                      // == Grafik Gula ==
                      LineChartBarData(
                        isCurved: true,        // Garis melengkung
                        color: Colors.blue,  // Warna garis
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

                      // == Grafik Garam ==
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

                      // ==Grafik Lemak ==
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

  // == CARD KONSUMSI HARIAN ==
  Widget _buildCardKonsumsi() {
    return Card(
      elevation: 2,  // Bayangan kartu
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildItem("Gula", 15, 50, Colors.blue),   // Item gula
            const SizedBox(height: 16),
            _buildItem("Garam", 4, 6, Colors.orange),  // Item garam
            const SizedBox(height: 16),
            _buildItem("Lemak", 45, 70, Colors.red),   // Item lemak
          ],
        ),
      ),
    );
  }

  // Widget untuk tiap baris konsumsi (Gula/Garam/Lemak)
  Widget _buildItem(String nama, int sekarang, int max, Color warna) {
    double persen = (sekarang / max).clamp(0, 1);    // Hitung progress bar

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nama, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              "$sekarang/$max g",        // Contoh: 15/50 g
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: persen,               // Progress pemakaian
          color: warna,                // Warna sesuai kategori
          backgroundColor: Colors.grey[200],
          minHeight: 10,               // Tinggi progress bar
        ),
      ],
    );
  }
}

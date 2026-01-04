import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import 'chatbotpage.dart';
import 'riwayat_page.dart';
import 'edukasi_page.dart';
import 'profil_page.dart';
import 'package:dailynutryapp/upload_page.dart';
import 'package:dailynutryapp/utils/rekomendasi_nutrisi.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _index = 0;

  final List<Widget> _pages = const [
    BerandaUtama(),
    RiwayatPage(),
    UploadPage(),
    EdukasiPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatbotPage()),
          );
        },
        child: const Icon(Icons.chat),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UploadPage()),
            );
          } else {
            setState(() => _index = i);
          }
        },
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
  // ================= DAILY =================
  double sugar = 0;
  double salt = 0;
  double fat = 0;
  bool isLoadingDaily = true;

  // ================= WEEKLY =================
  List<FlSpot> weeklySugar = [];
  List<FlSpot> weeklySalt = [];
  List<FlSpot> weeklyFat = [];
  List<String> tanggalMinggu = [];
  bool isLoadingWeekly = true;

  // ================= FETCH DAILY =================
  Future<void> fetchDailySummary() async {
    final url = Uri.parse(
      "https://june-chattable-tora.ngrok-free.dev/analysis/summary/daily",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          sugar = (data["total"]["sugar"] ?? 0).toDouble();
          salt = (data["total"]["salt"] ?? 0).toDouble();
          fat = (data["total"]["fat"] ?? 0).toDouble();
          isLoadingDaily = false;
        });
      }
    } catch (_) {
      isLoadingDaily = false;
    }
  }

  // ================= FETCH WEEKLY =================
  Future<void> fetchWeeklySummary() async {
    final url = Uri.parse(
      "https://june-chattable-tora.ngrok-free.dev/analysis/summary/weekly",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List data = body["data"];

        weeklySugar.clear();
        weeklySalt.clear();
        weeklyFat.clear();
        tanggalMinggu.clear();

        for (int i = 0; i < data.length; i++) {
          weeklySugar.add(
            FlSpot((i + 1).toDouble(), data[i]["sugar_pct"].toDouble()),
          );
          weeklySalt.add(
            FlSpot((i + 1).toDouble(), data[i]["salt_pct"].toDouble()),
          );
          weeklyFat.add(
            FlSpot((i + 1).toDouble(), data[i]["fat_pct"].toDouble()),
          );

          final date = DateTime.parse(data[i]["date"]);
          tanggalMinggu.add(date.day.toString());
        }

        setState(() => isLoadingWeekly = false);
      }
    } catch (_) {
      isLoadingWeekly = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDailySummary();
    fetchWeeklySummary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ================= HEADER =================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo, ${FirebaseAuth.instance.currentUser?.displayName ?? 'User'} 👋",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Pilih makanan yang aman",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),

        // ================= CONTENT =================
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Konsumsi Harian Anda",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              isLoadingDaily
                  ? const Center(child: CircularProgressIndicator())
                  : _buildDailyCard(),

              const SizedBox(height: 30),

              const Text(
                "Konsumsi Mingguan (%)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              isLoadingWeekly
                  ? const Center(child: CircularProgressIndicator())
                  : _buildWeeklyChart(),
            ],
          ),
        ),
      ],
    );
  }

  // ================= DAILY CARD =================
  Widget _buildDailyCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildItem("Gula", sugar, 50),
            const SizedBox(height: 16),
            _buildItem("Garam", salt, 5),
            const SizedBox(height: 16),
            _buildItem("Lemak", fat, 70),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String nama, double sekarang, double max) {
    final rec = getNutritionRecommendation(
      type: nama.toLowerCase(),
      current: sekarang,
      max: max,
    );

    final persenAsli = sekarang / max;
    final persen = persenAsli.clamp(0.0, 1.0);

    Color warna;
    if (persenAsli < 0.7) {
      warna = Colors.green;
    } else if (persenAsli <= 1) {
      warna = Colors.orange;
    } else {
      warna = Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$nama: ${sekarang.toStringAsFixed(1)} / $max g",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: persen,
          color: warna,
          backgroundColor: Colors.grey.shade300,
          minHeight: 10,
        ),
        if (rec != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                Icon(rec.icon, size: 16, color: rec.color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    rec.message,
                    style: TextStyle(fontSize: 12, color: rec.color),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ================= WEEKLY CHART =================
  Widget _buildWeeklyChart() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 260,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: LineChart(
            LineChartData(
              minX: 1,
              maxX: 7,
              minY: 0,
              maxY: 100,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (v, _) {
                      final i = v.toInt() - 1;
                      return i >= 0 && i < tanggalMinggu.length
                          ? Text(tanggalMinggu[i])
                          : const SizedBox();
                    },
                  ),
                ),
              ),
              lineBarsData: [
                _line(weeklySugar, Colors.green),
                _line(weeklySalt, Colors.orange),
                _line(weeklyFat, Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartBarData _line(List<FlSpot> data, Color color) {
    return LineChartBarData(
      spots: data,
      isCurved: true,
      barWidth: 3,
      color: color,
      dotData: FlDotData(show: false),
    );
  }
}

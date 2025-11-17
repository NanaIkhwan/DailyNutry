// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'chatbotpage.dart';
// import 'riwayat_page.dart';
// import 'edukasi_page.dart';
// import 'profil_page.dart';
// import 'package:dailynutryapp/upload_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser;
//   int _index = 0;

//   final List<Widget> _pages = [
//     const BerandaUtama(),
//     const RiwayatPage(),
//     const UploadPage(),
//     const EdukasiPage(),
//     const ProfilPage(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(130), // ✅ tambah tinggi AppBar
//         child: AppBar(
//           backgroundColor: Colors.greenAccent,
//           elevation: 0,
//           title: Column(
//             mainAxisAlignment:
//                 MainAxisAlignment.center, // ✅ teks di tengah vertikal
//             children: [
//               const SizedBox(height: 10), // ✅ jarak dari atas
//               Text(
//                 '${user!.email} 👋',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Selamat datang kembali!',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87, // ✅ ubah warna agar terlihat jelas
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
//           ],
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//           ),
//         ),
//       ),
//       body: const Center(child: Text('Isi halaman')),
//     );
//   }
// }

// class BerandaUtama extends StatelessWidget {
//   // final User? user;
//   const BerandaUtama({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Header atas
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF66BB6A), Color(0xFF4CAF50)],
//             ),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30),
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Baris: sapaan dan tombol lonceng
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Hai',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "Pilih makanan yang aman",
//                           style: TextStyle(color: Colors.white, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.notifications,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Belum ada notifikasi")),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Cari produk...",
//                     prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // Isi konten
//         Expanded(
//           child: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               const Text(
//                 "Konsumsi Harian Anda",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//               _buildCardKonsumsi(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Card konsumsi harian
//   Widget _buildCardKonsumsi() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildItem("Gula", 15, 50, Colors.green),
//             const SizedBox(height: 16),
//             _buildItem("Garam", 4, 6, Colors.orange),
//             const SizedBox(height: 16),
//             _buildItem("Lemak", 45, 70, Colors.red),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildItem(String nama, int sekarang, int max, Color warna) {
//     double persen = (sekarang / max).clamp(0, 1);
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(nama, style: const TextStyle(fontWeight: FontWeight.w600)),
//             Text(
//               "$sekarang/$max g",
//               style: const TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         LinearProgressIndicator(
//           value: persen,
//           color: warna,
//           backgroundColor: Colors.grey[200],
//           minHeight: 10,
//         ),
//       ],
//     );
//   }
// }

// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import 'khs_screen.dart';
import 'krs_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final mhs = provider.profile;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        children: [
          // Header biru melengkung khas figma
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mhs?.nama ?? "Nama Mahasiswa",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "NIM: ${mhs?.nim ?? '-'} | ${mhs?.prodi ?? '-'}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Navigasi ke Halaman Notifikasi
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Fitur Utama Grid Menu Akademik
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const Text(
                    "Layanan Akademik",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      _buildMenuButton(
                        context,
                        Icons.qr_code_scanner_rounded,
                        "Presensi",
                        Colors.orange,
                        () => _showQRModal(context),
                      ),
                      _buildMenuButton(
                        context,
                        Icons.assignment_rounded,
                        "KRS",
                        Colors.blue,
                        () {
                          // Navigasi ke Halaman KRS
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KrsScreen(),
                            ),
                          );
                        },
                      ),
                      _buildMenuButton(
                        context,
                        Icons.menu_book_rounded,
                        "KHS",
                        Colors.green,
                        () {
                          // Navigasi ke Halaman KHS
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KhsScreen(),
                            ),
                          );
                        },
                      ),
                      _buildMenuButton(
                        context,
                        Icons.info_outline_rounded,
                        "Biaya",
                        Colors.red,
                        () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Banner Notifikasi Penting
                  const Text(
                    "Informasi Terbaru",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Periode Pengisian KRS Semester Ganjil 2026 dibuka sampai akhir pekan ini.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Desain Dialog Skenario QR Valid/Tidak Valid dari figma
  void _showQRModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scan Presensi QR Kuliah",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text(
                  "Simulasi Scan QR Sukses",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  final res = await context
                      .read<StudentProvider>()
                      .prosesPresensi("VALID_PRESENSI_2026");
                  _showResultDialog(context, res);
                },
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Simulasi Scan QR Gagal"),
                onPressed: () async {
                  Navigator.pop(context);
                  final res = await context
                      .read<StudentProvider>()
                      .prosesPresensi("QR_EXPIRED_OR_INVALID");
                  _showResultDialog(context, res);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResultDialog(BuildContext context, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          isSuccess ? Icons.check_circle_rounded : Icons.cancel_rounded,
          color: isSuccess ? Colors.green : Colors.red,
          size: 50,
        ),
        title: Text(isSuccess ? "Presensi Berhasil" : "Presensi Tidak Valid"),
        content: Text(
          isSuccess
              ? "Kehadiran Anda berhasil tercatat ke dalam server perkuliahan."
              : "Kode QR tidak dikenali atau masa berlaku absen sesi ini telah berakhir.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

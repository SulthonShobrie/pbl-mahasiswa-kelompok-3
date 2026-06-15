// lib/screens/akun_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import 'edit_profile_screen.dart'; // <--- 1. Pastikan file edit_profile_screen di-import di sini

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data profil dari provider
    final mhs = context.watch<StudentProvider>().profile;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Akun",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- BAGIAN PROFIL (Foto, Nama, NIM, Prodi) ---
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    mhs?.nama ?? "Nama Mahasiswa",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mhs?.nim ?? "NIM",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mhs?.prodi ?? "Program Studi",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // --- DAFTAR MENU ---

            // 1. Menu Edit Profil (Sudah Diperbaiki Aksi Navigasinya)
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.edit_rounded, color: Color(0xFF1E3A8A)),
              ),
              title: const Text(
                "Edit Profil",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade400,
              ),
              onTap: () {
                // <--- 2. Ditambahkan Navigasi push ke halaman EditProfileScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(height: 1, color: Colors.grey.shade200),
            ),

            // 2. Menu Tentang Aplikasi
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Tentang Aplikasi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade400,
              ),
              onTap: () {
                // Aksi opsional tambahan jika diperlukan
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(height: 1, color: Colors.grey.shade200),
            ),

            // 3. Menu Logout
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.logout_rounded, color: Colors.red),
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.red,
              ),
              onTap: () => _showLogoutWarningDialog(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(height: 1, color: Colors.grey.shade200),
            ),
          ],
        ),
      ),
    );
  }

  // --- POPUP WARNING LOGOUT (Sesuai figma: akun - logout - warning.png) ---
  void _showLogoutWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Tutup Dialog Batal
            child: const Text("Batal", style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Tambahkan fungsi hapus session / auth token jika diperlukan di sini
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

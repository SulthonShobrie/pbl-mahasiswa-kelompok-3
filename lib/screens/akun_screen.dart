// lib/screens/akun_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';

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
        // Garis batas bawah AppBar tipis sesuai standar desain rapi
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),

          // --- BAGIAN PROFIL (Foto, Nama, NIM, Prodi) ---
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey.shade200,
                  // Jika ada aset gambar, ganti jadi: backgroundImage: AssetImage('assets/images/avatar.png')
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  mhs?.nama ?? "Nama Mahasiswa",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mhs?.nim ?? "NIM",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  mhs?.prodi ?? "Program Studi",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // --- BAGIAN MENU (Hanya Edit Profile & Logout) ---

          // Menu 1: Edit Profile
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 4,
            ),
            leading: const Icon(
              Icons.person_outline_rounded,
              color: Colors.black87,
            ),
            title: const Text("Edit Profile", style: TextStyle(fontSize: 16)),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
            ),
            onTap: () {
              // Navigasi ke halaman Edit Profile (sesuai figma: akun - edit profile.png)
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 1, color: Colors.grey.shade200),
          ),

          // Menu 2: Logout
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 4,
            ),
            leading: const Icon(Icons.logout_rounded, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, color: Colors.red),
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
            onPressed: () => Navigator.pop(context), // Tombol Batal
            child: const Text("Batal", style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Logika ketika beneran logout
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

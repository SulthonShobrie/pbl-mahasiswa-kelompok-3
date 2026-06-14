// lib/screens/notification_screen.dart
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy notifikasi
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "Pengingat KRS",
        "message":
            "Periode pengisian KRS akan ditutup dalam 2 hari. Segera selesaikan pengisian KRS Anda.",
        "time": "1 Jam yang lalu",
        "icon": Icons.warning_amber_rounded,
        "color": Colors.orange,
        "isRead": false,
      },
      {
        "title": "Materi Baru Diunggah",
        "message":
            "Dosen Dr. Eng. Hermawan, M.T. telah mengunggah materi baru untuk kelas Pemrograman Mobile.",
        "time": "4 Jam yang lalu",
        "icon": Icons.menu_book_rounded,
        "color": Colors.blue,
        "isRead": false,
      },
      {
        "title": "Pembayaran UKT Berhasil",
        "message":
            "Pembayaran UKT Semester Ganjil 2026/2027 telah berhasil diverifikasi.",
        "time": "Kemarin, 14:30",
        "icon": Icons.check_circle_outline_rounded,
        "color": Colors.green,
        "isRead": true,
      },
      {
        "title": "Perubahan Jadwal",
        "message":
            "Kelas Basis Data Terdistribusi dipindahkan ke ruang Lab Terpadu lantai 2 pada hari Jumat.",
        "time": "2 Hari yang lalu",
        "icon": Icons.event_repeat_rounded,
        "color": Colors.purple,
        "isRead": true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text(
          "Notifikasi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: notif['isRead']
                  ? Colors.white
                  : Colors.blue.shade50.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: notif['isRead']
                    ? Colors.grey.shade200
                    : Colors.blue.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (notif['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(notif['icon'], color: notif['color'], size: 24),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notif['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            notif['time'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        notif['message'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

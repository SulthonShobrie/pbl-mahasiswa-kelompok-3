// lib/screens/jadwal_screen.dart
import 'package:flutter/material.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  String _selectedDay = "Senin";

  final List<String> _days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
  ];

  // Data dummy jadwal per hari
  final Map<String, List<Map<String, dynamic>>> _jadwalData = {
    "Senin": [
      {
        "waktu": "08:00 - 10:30",
        "matkul": "Pemrograman Mobile (Flutter)",
        "ruang": "Lab Komputer 3",
        "dosen": "Dr. Eng. Hermawan, M.T.",
      },
      {
        "waktu": "13:00 - 15:30",
        "matkul": "Basis Data Terdistribusi",
        "ruang": "Ruang Kuliah Ruang 402",
        "dosen": "Fitriani, S.Kom., M.Kom.",
      },
    ],
    "Selasa": [
      {
        "waktu": "10:00 - 12:30",
        "matkul": "Kecerdasan Buatan",
        "ruang": "Ruang Teori 201",
        "dosen": "Budi Santoso, M.T.",
      },
    ],
    "Rabu": [
      {
        "waktu": "08:00 - 10:30",
        "matkul": "Manajemen Proyek Perangkat Lunak",
        "ruang": "Ruang Teori 105",
        "dosen": "Rina Kumala, M.Sc.",
      },
      {
        "waktu": "10:40 - 12:20",
        "matkul": "Interaksi Manusia dan Komputer",
        "ruang": "Lab Multimedia",
        "dosen": "Ahmad Fauzi, S.Kom.",
      },
    ],
    "Kamis": [], // Skenario Jadwal Kosong
    "Jumat": [
      {
        "waktu": "09:00 - 11:30",
        "matkul": "Praktikum Pemrograman Mobile",
        "ruang": "Lab Terpadu Lt. 2",
        "dosen": "Dr. Eng. Hermawan, M.T.",
      },
    ],
    "Sabtu": [], // Skenario Jadwal Kosong
  };

  @override
  Widget build(BuildContext context) {
    final hariIniJadwal = _jadwalData[_selectedDay] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text(
          "Jadwal Kuliah",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Selector Hari Horizontal khas figma
          Container(
            color: const Color(0xFF1E3A8A),
            padding: const EdgeInsets.only(bottom: 15, top: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: _days.map((day) {
                  bool isSelected = _selectedDay == day;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = day;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.white12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF1E3A8A)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Daftar Jadwal Kuliah
          Expanded(
            child: hariIniJadwal.isEmpty
                ? _buildEmptyJadwalState()
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: hariIniJadwal.length,
                    itemBuilder: (context, index) {
                      final matkul = hariIniJadwal[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Waktu Kelas
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                    color: Color(0xFF1E3A8A),
                                    size: 18,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    matkul['waktu'].replaceAll(
                                      " - ",
                                      "\ns/d\n",
                                    ),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF1E3A8A),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            // Rincian Kelas
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    matkul['matkul'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        matkul['ruang'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person_outline_rounded,
                                        size: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          matkul['dosen'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Tampilan figma saat tidak ada jadwal
  Widget _buildEmptyJadwalState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            const Text(
              "Tidak Ada Jadwal Kuliah",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Hari $_selectedDay ini Anda bebas dari kelas akademik. Silakan istirahat atau belajar mandiri!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

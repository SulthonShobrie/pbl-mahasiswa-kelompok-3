// lib/screens/khs_screen.dart
import 'package:flutter/material.dart';

class KhsScreen extends StatefulWidget {
  const KhsScreen({super.key});

  @override
  State<KhsScreen> createState() => _KhsScreenState();
}

class _KhsScreenState extends State<KhsScreen> {
  String _selectedSemester = "Semester 4";

  final List<String> _semesters = [
    "Semester 1",
    "Semester 2",
    "Semester 3",
    "Semester 4",
    "Semester 5 (Baru)",
  ];

  // Dummy nilai matkul KHS
  final List<Map<String, dynamic>> _khsData = [
    {"kode": "IF-201", "matkul": "Struktur Data", "sks": 3, "nilai": "A"},
    {
      "kode": "IF-204",
      "matkul": "Pemrograman Berorientasi Objek",
      "sks": 4,
      "nilai": "A-",
    },
    {"kode": "IF-206", "matkul": "Sistem Operasi", "sks": 3, "nilai": "B+"},
    {"kode": "IF-209", "matkul": "Jaringan Komputer", "sks": 3, "nilai": "A"},
    {"kode": "IF-211", "matkul": "Metode Numerik", "sks": 2, "nilai": "B"},
  ];

  @override
  Widget build(BuildContext context) {
    // Kondisi jika memilih Semester 5, simulasikan periode belum dibuka
    bool isBelumDibuka = _selectedSemester == "Semester 5 (Baru)";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text(
          "Kartu Hasil Studi (KHS)",
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
      body: Column(
        children: [
          // Dropdown Filter Semester
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pilih Semester:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSemester,
                      items: _semesters.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSemester = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: isBelumDibuka
                ? _buildPeriodeBelumDibukaState()
                : ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      // Ringkasan IP Ring / Card Informasi IPS & IPK
                      Row(
                        children: [
                          _buildIpCard("IPS Semester Ini", "3.72", Colors.blue),
                          const SizedBox(width: 15),
                          _buildIpCard("IPK Kumulatif", "3.68", Colors.green),
                        ],
                      ),
                      const SizedBox(height: 25),

                      const Text(
                        "Rincian Nilai Mata Kuliah",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // List Nilai
                      ..._khsData.map(
                        (data) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['matkul'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${data['kode']} • ${data['sks']} SKS",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  data['nilai'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildIpCard(String title, String score, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 5),
            Text(
              score,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan figma saat KHS Periode Belum Dibuka
  Widget _buildPeriodeBelumDibukaState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_clock_rounded,
              size: 75,
              color: Colors.orange.shade300,
            ),
            const SizedBox(height: 20),
            const Text(
              "Periode KHS Belum Dibuka",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Nilai untuk $_selectedSemester saat ini masih dalam proses kalkulasi & verifikasi dosen DPA. Silakan cek kembali dalam beberapa waktu.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

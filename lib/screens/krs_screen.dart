// lib/screens/krs_screen.dart
import 'package:flutter/material.dart';

class KrsScreen extends StatelessWidget {
  const KrsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy simulasi KRS (Nantinya bisa diganti dengan data dari Provider/API)
    final List<Map<String, dynamic>> krsList = [
      {
        "kode": "IF-302",
        "matkul": "Pemrograman Mobile (Flutter)",
        "sks": 3,
        "dosen": "Dr. Eng. Hermawan, M.T.",
      },
      {
        "kode": "IF-305",
        "matkul": "Basis Data Terdistribusi",
        "sks": 4,
        "dosen": "Fitriani, S.Kom., M.Kom.",
      },
      {
        "kode": "IF-308",
        "matkul": "Kecerdasan Buatan",
        "sks": 3,
        "dosen": "Budi Santoso, M.T.",
      },
      {
        "kode": "IF-310",
        "matkul": "Manajemen Proyek Perangkat Lunak",
        "sks": 3,
        "dosen": "Rina Kumala, M.Sc.",
      },
      {
        "kode": "IF-312",
        "matkul": "Interaksi Manusia dan Komputer",
        "sks": 2,
        "dosen": "Ahmad Fauzi, S.Kom.",
      },
    ];

    // Menghitung total SKS
    int totalSks = krsList.fold(0, (sum, item) => sum + (item['sks'] as int));

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text(
          "Kartu Rencana Studi",
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
          // Header Info Semester & Total SKS
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Semester Ganjil 2026/2027",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Status: Disetujui Dosen PA",
                      style: TextStyle(
                        color: Colors.greenAccent.shade200,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Total SKS",
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "$totalSks",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Daftar Mata Kuliah
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: krsList.length,
              itemBuilder: (context, index) {
                final matkul = krsList[index];
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${matkul['sks']}\nSKS",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
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
                              const SizedBox(height: 5),
                              Text(
                                "Kode: ${matkul['kode']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "Dosen: ${matkul['dosen']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Tombol Cetak KRS
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          icon: const Icon(Icons.print_rounded, color: Colors.white),
          label: const Text(
            "Cetak KRS (PDF)",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Mengunduh KRS PDF...")),
            );
          },
        ),
      ),
    );
  }
}

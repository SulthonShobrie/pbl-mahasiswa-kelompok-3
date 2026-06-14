// lib/screens/kelas_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student_models.dart';
import '../providers/student_provider.dart';

class KelasScreen extends StatelessWidget {
  const KelasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kelasList = context.watch<StudentProvider>().daftarKelas;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text(
          "Kelas Kuliah Saya",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
      ),
      body: kelasList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.class_outlined,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Belum Ada Kelas",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: kelasList.length,
              itemBuilder: (context, index) {
                final kelas = kelasList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    title: Text(
                      kelas.namaMataKuliah,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "${kelas.kode} • ${kelas.SKS}\nDosen: ${kelas.dosenPengampu}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailIsiKelasScreen(kelas: kelas),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class DetailIsiKelasScreen extends StatelessWidget {
  final KelasKuliah kelas;
  const DetailIsiKelasScreen({super.key, required this.kelas});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FB),
        appBar: AppBar(
          title: Text(
            kelas.namaMataKuliah,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFF1E3A8A),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(text: "Sesi Pertemuan"),
              Tab(text: "Teman Sekelas"),
            ],
          ),
        ),
        body: TabBarView(children: [_buildSesiTab(context), _buildTemanTab()]),
      ),
    );
  }

  Widget _buildSesiTab(BuildContext context) {
    if (kelas.sesiList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 60,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 15),
            Text(
              "Sesi belum tersedia.",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: kelas.sesiList.length,
      itemBuilder: (context, index) {
        final sesi = kelas.sesiList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: const Color(0xFF1E3A8A),
              title: Text(
                "Pertemuan Ke-${sesi.pertemuanKe}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "${sesi.tanggal}\n${sesi.topik}",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              childrenPadding: const EdgeInsets.all(20),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status Presensi: ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: sesi.isHadir
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sesi.isHadir ? Colors.green : Colors.red,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        sesi.isHadir ? "Hadir" : "Alpha",
                        style: TextStyle(
                          color: sesi.isHadir ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 10),
                const Text(
                  "Materi Kuliah:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 10),

                // Kondisi Jika Materi Kosong vs Ada Materi
                sesi.daftarMateri.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.orange,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Dosen belum mengunggah materi pada sesi ini.",
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: sesi.daftarMateri.map((materi) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              leading: const Icon(
                                Icons.picture_as_pdf_rounded,
                                color: Colors.redAccent,
                                size: 30,
                              ),
                              title: Text(
                                materi.judul,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${materi.tipeFile} • ${materi.ukuran}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.download_rounded,
                                  color: Color(0xFF1E3A8A),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Mengunduh ${materi.judul}...",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTemanTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: kelas.temanSekelas.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Text(
                kelas.temanSekelas[index][0], // Huruf pertama nama
                style: const TextStyle(
                  color: Color(0xFF1E3A8A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              kelas.temanSekelas[index],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: const Text(
              "Mahasiswa Aktif",
              style: TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}

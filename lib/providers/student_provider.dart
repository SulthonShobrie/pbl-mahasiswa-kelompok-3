// lib/providers/student_provider.dart
import 'package:flutter/material.dart';
import '../models/student_models.dart';

class StudentProvider extends ChangeNotifier {
  bool _isLoading = true;
  StudentProfile? _profile;
  List<KelasKuliah> _daftarKelas = [];

  bool get isLoading => _isLoading;
  StudentProfile? get profile => _profile;
  List<KelasKuliah> get daftarKelas => _daftarKelas;

  StudentProvider() {
    _loadDataDataAkademik();
  }

  Future<void> _loadDataDataAkademik() async {
    // Simulasi penarikan data awal dari server/Figma skenario
    await Future.delayed(const Duration(seconds: 1));

    _profile = StudentProfile(
      nama: "Rian Aditya",
      nim: "2201010145",
      prodi: "Teknik Informatika",
    );

    _daftarKelas = [
      KelasKuliah(
        kode: "IF-302",
        namaMataKuliah: "Pemrograman Mobile (Flutter)",
        SKS: 3,
        dosenPengampu: "Dr. Eng. Hermawan, M.T.",
        temanSekelas: [
          "Ahmad Dhani",
          "Budi Utomo",
          "Citra Kirana",
          "Dedi Corbuzier",
          "Eka Saputra",
        ],
        sesiList: [
          SesiKuliah(
            pertemuanKe: 1,
            tanggal: "Senin, 2 Maret 2026",
            topik: "Pengenalan Widget & Arsitektur Flutter",
            isHadir: true,
            daftarMateri: [
              Materi(
                judul: "Slide Pendahuluan Flutter.pdf",
                tipeFile: "PDF",
                ukuran: "2.4 MB",
              ),
              Materi(
                judul: "Modul Praktikum 1.pdf",
                tipeFile: "PDF",
                ukuran: "1.1 MB",
              ),
            ],
          ),
          SesiKuliah(
            pertemuanKe: 2,
            tanggal: "Senin, 9 Maret 2026",
            topik: "State Management dengan Provider",
            isHadir: true,
            daftarMateri: [], // Menguji skenario materi kosong dari Figma
          ),
        ],
      ),
      KelasKuliah(
        kode: "IF-305",
        namaMataKuliah: "Basis Data Terdistribusi",
        SKS: 4,
        dosenPengampu: "Fitriani, S.Kom., M.Kom.",
        temanSekelas: ["Fany Arianti", "Gita Gutawa", "Hendra Setiawan"],
        sesiList: [
          SesiKuliah(
            pertemuanKe: 1,
            tanggal: "Senin, 2 Maret 2026",
            topik: "Konsep Dasar Desentralisasi Data",
            isHadir: true,
            daftarMateri: [
              Materi(
                judul: "Buku Referensi Distributed DB.pdf",
                tipeFile: "PDF",
                ukuran: "14.5 MB",
              ),
            ],
          ),
        ],
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  // Simulasi cek validitas QR Code Presensi
  Future<bool> prosesPresensi(String qrCode) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    _isLoading = false;
    notifyListeners();

    if (qrCode == "VALID_PRESENSI_2026") {
      return true;
    } else {
      return false;
    }
  }
}

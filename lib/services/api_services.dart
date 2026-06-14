// lib/services/api_service.dart
import '../models/student_models.dart';

class ApiService {
  // Simulasi hit API Fetch Profil Mahasiswa
  Future<StudentProfile> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Network delay
    return StudentProfile(
      nim: "2201082014",
      nama: "Rian Hidayat",
      prodi: "Teknik Informatika",
    );
  }

  // Simulasi hit API Fetch Kelas Kuliah Aktif
  Future<List<KelasKuliah>> getKelasAktif() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return [
      KelasKuliah(
        kode: "IF-302",
        namaMataKuliah: "Pemrograman Mobile (Flutter)",
        SKS: 3, // Diubah menjadi int agar match dengan model
        dosenPengampu: "Dr. Eng. Hermawan, M.T.",
        temanSekelas: [
          "Ahmad Fauzi",
          "Siti Aminah",
          "Budi Utomo",
          "Clara Shinta",
          "Dedi Kurniawan",
        ],
        sesiList: [
          SesiKuliah(
            // Diubah dari SesiPertemuan ke SesiKuliah
            pertemuanKe: 1,
            topik: "Pengenalan Widget & Arsitektur Flutter",
            tanggal: "12 Juni 2026",
            isHadir: true,
            daftarMateri: [
              Materi(
                judul: "Slide_Pengenalan_Flutter.pdf",
                tipeFile: "PDF",
                ukuran: "4.2 MB",
              ),
              Materi(
                judul: "Source_Code_Pertemuan_1.zip",
                tipeFile: "ZIP",
                ukuran: "12.5 MB",
              ),
            ],
          ),
          SesiKuliah(
            // Diubah dari SesiPertemuan ke SesiKuliah
            pertemuanKe: 2,
            topik: "State Management menggunakan Provider",
            tanggal: "19 Juni 2026",
            isHadir: true,
            daftarMateri: [], // Menguji kondisi empty state materi sesuai figma
          ),
        ],
      ),
      KelasKuliah(
        kode: "IF-305",
        namaMataKuliah: "Basis Data Terdistribusi",
        SKS: 4, // Diubah menjadi int
        dosenPengampu: "Fitriani, S.Kom., M.Kom.",
        temanSekelas: ["Ahmad Fauzi", "Budi Utomo", "Dedi Kurniawan"],
        sesiList: [],
      ),
    ];
  }

  // Simulasi Validasi QR Absen Kuliah
  Future<bool> validateQRPresensi(String qrCode) async {
    await Future.delayed(const Duration(seconds: 1));
    // Validasi kode QR dinamis sesuai petunjuk figma
    if (qrCode.contains("VALID_PRESENSI_2026")) {
      return true;
    }
    return false;
  }
}

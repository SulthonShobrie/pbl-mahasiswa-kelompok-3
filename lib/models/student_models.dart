// lib/models/student_models.dart

class StudentProfile {
  final String nama;
  final String nim;
  final String prodi;

  StudentProfile({required this.nama, required this.nim, required this.prodi});
}

class Materi {
  final String judul;
  final String tipeFile;
  final String ukuran;

  Materi({required this.judul, required this.tipeFile, required this.ukuran});
}

class SesiKuliah {
  final int pertemuanKe;
  final String tanggal;
  final String topik;
  final bool isHadir;
  final List<Materi> daftarMateri;

  SesiKuliah({
    required this.pertemuanKe,
    required this.tanggal,
    required this.topik,
    required this.isHadir,
    required this.daftarMateri,
  });
}

class KelasKuliah {
  final String kode;
  final String namaMataKuliah;
  final int SKS;
  final String dosenPengampu;
  final List<SesiKuliah> sesiList;
  final List<String> temanSekelas;

  KelasKuliah({
    required this.kode,
    required this.namaMataKuliah,
    required this.SKS,
    required this.dosenPengampu,
    required this.sesiList,
    required this.temanSekelas,
  });
}

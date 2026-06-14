// lib/models/student_models.dart

class StudentProfile {
  final String nama;
  final String nim;
  final String prodi;

  // Struktur bersih sesuai Figma Akun Profil
  StudentProfile({required this.nama, required this.nim, required this.prodi});

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      prodi: json['prodi'] ?? '',
    );
  }
}

class Materi {
  final String judul;
  final String tipeFile;
  final String ukuran;

  Materi({required this.judul, required this.tipeFile, required this.ukuran});

  factory Materi.fromJson(Map<String, dynamic> json) {
    return Materi(
      judul: json['judul'] ?? '',
      tipeFile: json['tipe_file'] ?? 'PDF',
      ukuran: json['ukuran'] ?? '0 MB',
    );
  }
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

  factory SesiKuliah.fromJson(Map<String, dynamic> json) {
    var materiList = json['daftar_materi'] as List? ?? [];
    return SesiKuliah(
      pertemuanKe: json['pertemuan_ke'] ?? 0,
      tanggal: json['tanggal'] ?? '',
      topik: json['topik'] ?? '',
      isHadir: json['is_hadir'] ?? false,
      daftarMateri: materiList.map((m) => Materi.fromJson(m)).toList(),
    );
  }
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

  factory KelasKuliah.fromJson(Map<String, dynamic> json) {
    var sesi = json['sesi_list'] as List? ?? [];
    var teman = json['teman_sekelas'] as List? ?? [];
    return KelasKuliah(
      kode: json['kode'] ?? '',
      namaMataKuliah: json['nama_mata_kuliah'] ?? '',
      SKS: json['sks'] is int
          ? json['sks']
          : int.parse(json['sks'].toString().replaceAll(RegExp(r'[^0-9]'), '')),
      dosenPengampu: json['dosen_pengampu'] ?? '',
      sesiList: sesi.map((s) => SesiKuliah.fromJson(s)).toList(),
      temanSekelas: teman.map((t) => t.toString()).toList(),
    );
  }
}

// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/student_models.dart';

class ApiService {
  // Membaca Base URL API Kelompok 3 (Mahasiswa) dari file .env
  final String baseUrl =
      dotenv.env['API_KELOMPOK_3'] ??
      'https://api-mahasiswa-4a.akufarish.my.id:8874';

  // Headers standar untuk JSON API
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // 1. HIT API - Profil Mahasiswa (Sesuai Figma Akun Profil)
  Future<StudentProfile> getProfile() async {
    final url = Uri.parse('$baseUrl/api/mahasiswa/profile');

    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return StudentProfile.fromJson(data);
      } else {
        throw Exception('Gagal memuat profil: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Kesalahan koneksi API Profil: $e');
    }
  }

  // 2. HIT API - Daftar Kelas & Sesi Kuliah (Sesuai Figma Kelas, Sesi & Materi)
  Future<List<KelasKuliah>> getKelasAktif() async {
    final url = Uri.parse('$baseUrl/api/mahasiswa/kelas');

    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => KelasKuliah.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat daftar kelas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Kesalahan koneksi API Kelas: $e');
    }
  }

  // 3. HIT API - Validasi Scan QR Presensi (Sesuai Figma Presensi Scan QR & Warning QR)
  Future<bool> validateQRPresensi(String qrCode) async {
    final url = Uri.parse('$baseUrl/api/mahasiswa/presensi');

    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({'qr_code_token': qrCode}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        return result['status'] == true || result['success'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

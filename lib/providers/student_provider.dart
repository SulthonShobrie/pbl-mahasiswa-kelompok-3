// lib/providers/student_provider.dart
import 'package:flutter/material.dart';
import '../models/student_models.dart';
import '../services/api_services.dart'; // <--- Sudah disesuaikan menjadi 'service' tanpa 's'

class StudentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = true;
  String? _errorMessage;
  StudentProfile? _profile;
  List<KelasKuliah> _daftarKelas = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  StudentProfile? get profile => _profile;
  List<KelasKuliah> get daftarKelas => _daftarKelas;

  StudentProvider() {
    fetchDataAkademik();
  }

  // Menarik data nyata dari server backend
  Future<void> fetchDataAkademik() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Menjalankan request API
      final profileData = await _apiService.getProfile();
      final kelasData = await _apiService.getKelasAktif();

      _profile = profileData;
      _daftarKelas = kelasData;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("Error fetching API: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Proses validasi scan QR presensi kuliah langsung ke server API
  Future<bool> prosesPresensi(String qrCode) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;
    try {
      isSuccess = await _apiService.validateQRPresensi(qrCode);
    } catch (e) {
      debugPrint("Error presensi API: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return isSuccess;
  }
}

// lib/screens/presensi_scan_qr_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';

class PresensiScanQrScreen extends StatefulWidget {
  const PresensiScanQrScreen({super.key});

  @override
  State<PresensiScanQrScreen> createState() => _PresensiScanQrScreenState();
}

class _PresensiScanQrScreenState extends State<PresensiScanQrScreen> {
  final MobileScannerController _cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed
        .noDuplicates, // Mencegah scan ganda dalam waktu bersamaan
  );
  bool _hasScanned = false; // Pengunci agar tidak menembak API berkali-kali
  bool _isTorchOn =
      false; // Variabel lokal untuk melacak status senter (on/off)

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  // Fungsi untuk memproses hasil scan QR
  void _onQrDetected(BarcodeCapture capture) async {
    if (_hasScanned) return; // Jika sedang proses API, abaikan scan baru

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      setState(() {
        _hasScanned = true;
      });

      final String qrCodeData = barcodes.first.rawValue!;
      debugPrint('QR Code Terdeteksi: $qrCodeData');

      // Stop kamera sementara saat loading hit API
      await _cameraController.stop();

      // Hit API via Provider
      if (!mounted) return;
      final provider = context.read<StudentProvider>();
      bool isSuccess = await provider.prosesPresensi(qrCodeData);

      if (!mounted) return;

      // Tampilkan dialog hasil presensi sesuai skenario Figma (Valid / Invalid)
      _showResultDialog(isSuccess);
    }
  }

  // Tampilan pop-up alert warning valid/tidak valid sesuai figma
  void _showResultDialog(bool success) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: Icon(
            success ? Icons.check_circle : Icons.warning_rounded,
            color: success ? Colors.green : Colors.red,
            size: 60,
          ),
          title: Text(
            success ? "Presensi Sukses!" : "Presensi Gagal",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            success
                ? "Data presensi kehadiran Anda berhasil dicatat ke dalam sistem akademik."
                : "QR Code tidak valid, sudah kedaluwarsa, atau token tidak dikenali oleh sistem.",
            textAlign: TextAlign.center,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: success ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                  if (success) {
                    Navigator.pop(context); // Kembali ke Beranda jika sukses
                  } else {
                    // Reset scanner agar bisa memindai ulang jika gagal
                    setState(() {
                      _hasScanned = false;
                    });
                    _cameraController.start();
                  }
                },
                child: const Text(
                  "Oke",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<StudentProvider>().isLoading;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Scan QR Presensi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Tombol Flashlight / Senter yang aman dari perubahan versi library
          IconButton(
            icon: Icon(
              _isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: _isTorchOn ? Colors.yellow : Colors.white,
            ),
            onPressed: () {
              _cameraController.toggleTorch();
              setState(() {
                _isTorchOn = !_isTorchOn; // Tukar status senter
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Kamera Scanner Utama
          MobileScanner(controller: _cameraController, onDetect: _onQrDetected),

          // 2. Overlay Grafis Kotak Pembidik (Scanner Frame)
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1E3A8A), width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // 3. Teks Petunjuk di bawah Kotak
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: const Text(
              "Posisikan QR Code di dalam kotak pembidik",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                shadows: [Shadow(color: Colors.black, blurRadius: 4)],
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // 4. Loading Indikator saat Hit API Backend Berlangsung
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Color(0xFF1E3A8A)),
                    SizedBox(height: 15),
                    Text(
                      "Memvalidasi Presensi...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';

class LaporanBencana {
  final String id;
  final String namaPelapor;
  final String namaBencana;
  final String lokasi;
  final String keterangan;
  final bool setujuData;
  final DateTime tanggalLaporan;

  LaporanBencana({
    required this.id,
    required this.namaPelapor,
    required this.namaBencana,
    required this.lokasi,
    required this.keterangan,
    required this.setujuData,
    required this.tanggalLaporan,
  });
}

class LaporanModel extends ChangeNotifier {
  final List<LaporanBencana> _daftarLaporan = [];

  List<LaporanBencana> get daftarLaporan =>
      List.unmodifiable(_daftarLaporan);

  void tambahLaporan(LaporanBencana laporan) {
    _daftarLaporan.add(laporan);
    notifyListeners();
  }

  LaporanBencana? cariLaporan(String id) {
    for (final laporan in _daftarLaporan) {
      if (laporan.id == id) {
        return laporan;
      }
    }

    return null;
  }

  int get jumlahLaporan => _daftarLaporan.length;
}
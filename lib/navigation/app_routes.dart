import 'package:flutter/material.dart';

import '../pages/halaman_detail.dart';
import '../pages/halaman_form_laporan.dart';
import '../pages/halaman_detail_laporan.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_tentang.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String mitigasi = '/mitigasi';
  static const String laporan = '/laporan';
  static const String detail = '/detail';
  static const String formLaporan = '/form-laporan';
  static const String detailLaporan = '/detail-laporan';
  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      mitigasi: (context) =>
          const KerangkaNavigasi(indeksAwal: 1),
      laporan: (context) =>
          const KerangkaNavigasi(indeksAwal: 2),
      formLaporan: (context) => const HalamanFormLaporan(),
      pengaturan: (context) => const HalamanPengaturan(),
      tentang: (context) => const HalamanTentang(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final argumen =
          settings.arguments as Map<String, String>? ?? {};

      return MaterialPageRoute(
        builder: (context) => HalamanDetail(
          namaBencana: argumen['namaBencana'] ?? 'Bencana',
          lokasi: argumen['lokasi'] ?? 'Kota Palu',
          keterangan:
              argumen['keterangan'] ?? 'Tidak ada keterangan.',
        ),
      );
    }

    if (settings.name == detailLaporan) {
      final id = settings.arguments as String?;

      if (id == null) {
        return routeTidakDikenal(settings);
      }

      return MaterialPageRoute(
        builder: (context) => HalamanDetailLaporan(
          laporanId: id,
        ),
      );
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Halaman Tidak Ditemukan'),
        ),
        body: Center(
          child: Text(
            'Route "${settings.name}" tidak tersedia.',
          ),
        ),
      ),
    );
  }
}
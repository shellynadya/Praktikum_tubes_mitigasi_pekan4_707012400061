import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/laporan_model.dart';

class HalamanDetailLaporan extends StatelessWidget {
  final String laporanId;

  const HalamanDetailLaporan({
    super.key,
    required this.laporanId,
  });

  @override
  Widget build(BuildContext context) {
    final laporan = context
        .watch<LaporanModel>()
        .cariLaporan(laporanId);

    if (laporan == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Laporan'),
        ),
        body: const Center(
          child: Text('Data laporan tidak ditemukan.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Laporan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laporan.namaBencana,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Nama Pelapor',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(laporan.namaPelapor),

                const SizedBox(height: 16),

                const Text(
                  'Lokasi Kejadian',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(laporan.lokasi),

                const SizedBox(height: 16),

                const Text(
                  'Jenis Bencana',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(laporan.namaBencana),

                const SizedBox(height: 16),

                const Text(
                  'Keterangan Kejadian',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(laporan.keterangan),

                const SizedBox(height: 16),

                const Text(
                  'Tanggal Laporan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${laporan.tanggalLaporan.day}/'
                  '${laporan.tanggalLaporan.month}/'
                  '${laporan.tanggalLaporan.year}',
                ),

                const SizedBox(height: 16),

                const Text(
                  'Persetujuan Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  laporan.setujuData
                      ? 'Disetujui'
                      : 'Tidak disetujui',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/bencana_model.dart';
import '../model/laporan_model.dart';
import '../navigation/app_routes.dart';

class HalamanLaporan extends StatelessWidget {
  const HalamanLaporan({super.key});

  static const List<Map<String, String>> laporanBawaan = [
    {
      'namaBencana': 'Laporan Gempa Bumi',
      'lokasi': 'Kota Palu',
      'keterangan':
          'Laporan mengenai kondisi gempa bumi dan keadaan '
          'lingkungan di sekitar Kota Palu.',
    },
    {
      'namaBencana': 'Laporan Banjir',
      'lokasi': 'Kota Palu',
      'keterangan':
          'Laporan mengenai genangan atau banjir yang terjadi '
          'di wilayah Kota Palu.',
    },
    {
      'namaBencana': 'Laporan Kerusakan Fasilitas',
      'lokasi': 'Kota Palu',
      'keterangan':
          'Laporan mengenai fasilitas umum yang mengalami '
          'kerusakan akibat bencana.',
    },
  ];

  Future<void> bukaDetailBawaan(
    BuildContext context,
    Map<String, String> data,
  ) async {
    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.detail,
      arguments: {
        'namaBencana': data['namaBencana']!,
        'lokasi': data['lokasi']!,
        'keterangan': data['keterangan']!,
      },
    );

    if (!context.mounted) return;

    if (hasil is String) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(hasil),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bencanaModel = context.watch<BencanaModel>();
    final laporanModel = context.watch<LaporanModel>();

    final laporanBaru =
        laporanModel.daftarLaporan.reversed.toList();

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          children: [
            const Text(
              'Laporan Bencana',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Pilih laporan untuk melihat informasi '
              'lebih lengkap.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Bencana yang Dipantau',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (bencanaModel.dipantau.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Icon(Icons.star_border),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Belum ada bencana yang dipantau.',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...bencanaModel.dipantau.map(
                (namaBencana) => Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    title: Text(
                      namaBencana,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text('Sedang dipantau'),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        context
                            .read<BencanaModel>()
                            .hapusPantauan(namaBencana);
                      },
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Laporan dari Pengguna',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    '${laporanModel.jumlahLaporan} laporan',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (laporanBaru.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'Belum ada laporan baru. '
                    'Tekan tombol + untuk membuat laporan.',
                  ),
                ),
              )
            else
              ...laporanBaru.map(
                (laporan) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(14),
                      leading: const CircleAvatar(
                        child: Icon(Icons.assignment),
                      ),
                      title: Text(
                        laporan.namaBencana,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${laporan.lokasi}\n'
                        'Pelapor: ${laporan.namaPelapor}',
                      ),
                      isThreeLine: true,
                      trailing:
                          const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.detailLaporan,
                          arguments: laporan.id,
                        );
                      },
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            const Text(
              'Daftar Laporan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...laporanBawaan.map(
              (data) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.report_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      data['namaBencana']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(data['lokasi']!),
                    trailing:
                        const Icon(Icons.chevron_right),
                    onTap: () {
                      bukaDetailBawaan(context, data);
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.orange.shade200,
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Gunakan fitur laporan untuk '
                      'menyampaikan informasi mengenai '
                      'kondisi bencana di sekitar Kota Palu.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            heroTag: 'fab_buat_laporan',
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.formLaporan,
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Buat Laporan'),
          ),
        ),
      ],
    );
  }
}
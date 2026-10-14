import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/bencana_model.dart';
import '../navigation/app_routes.dart';

class HalamanMitigasi extends StatefulWidget {
  const HalamanMitigasi({super.key});

  @override
  State<HalamanMitigasi> createState() => _HalamanMitigasiState();
}

class _HalamanMitigasiState extends State<HalamanMitigasi> {
  int _tabTerpilih = 0;

  final List<String> _namaTab = [
    'Gempa',
    'Tsunami',
    'Banjir',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: Row(
            children: List.generate(
              _namaTab.length,
              (index) {
                final aktif = _tabTerpilih == index;

                return Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _tabTerpilih = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            index == 0
                                ? Icons.vibration
                                : index == 1
                                    ? Icons.waves
                                    : Icons.water,
                            color: aktif
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _namaTab[index],
                            style: TextStyle(
                              color: aktif
                                  ? Colors.blue
                                  : Colors.grey,
                              fontWeight: aktif
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (aktif)
                            Container(
                              height: 3,
                              width: 50,
                              color: Colors.blue,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const Divider(height: 1),

        Expanded(
          child: IndexedStack(
            index: _tabTerpilih,
            children: [
              _daftarBencana(
                context,
                [
                  {
                    'nama': 'Gempa Bumi',
                    'lokasi': 'Kota Palu',
                    'keterangan':
                        'Gempa bumi dapat terjadi secara tiba-tiba. '
                        'Segera berlindung di tempat yang aman, '
                        'jauhi kaca dan benda yang mudah jatuh.',
                  },
                  {
                    'nama': 'Gempa Saat Berada di Dalam Rumah',
                    'lokasi': 'Rumah atau Bangunan',
                    'keterangan':
                        'Berlindung di bawah meja yang kokoh, '
                        'jauhkan diri dari jendela, kemudian keluar '
                        'setelah guncangan berhenti.',
                  },
                  {
                    'nama': 'Gempa Saat Berada di Luar',
                    'lokasi': 'Area Terbuka',
                    'keterangan':
                        'Jauhi bangunan, tiang listrik, pohon, '
                        'dan benda lain yang dapat roboh.',
                  },
                ],
              ),
              _daftarBencana(
                context,
                [
                  {
                    'nama': 'Tsunami',
                    'lokasi': 'Wilayah Pesisir Kota Palu',
                    'keterangan':
                        'Jika terjadi gempa kuat dan berlangsung lama '
                        'di wilayah pesisir, segera menuju tempat '
                        'yang lebih tinggi.',
                  },
                  {
                    'nama': 'Evakuasi Tsunami',
                    'lokasi': 'Jalur Evakuasi',
                    'keterangan':
                        'Ikuti jalur evakuasi dan petunjuk petugas. '
                        'Jangan kembali ke rumah sebelum dinyatakan aman.',
                  },
                  {
                    'nama': 'Tanda-Tanda Tsunami',
                    'lokasi': 'Wilayah Pesisir',
                    'keterangan':
                        'Perhatikan perubahan kondisi laut setelah '
                        'gempa dan ikuti informasi resmi dari pihak berwenang.',
                  },
                ],
              ),
              _daftarBencana(
                context,
                [
                  {
                    'nama': 'Banjir',
                    'lokasi': 'Kota Palu',
                    'keterangan':
                        'Hindari daerah yang tergenang dan segera '
                        'menuju tempat yang lebih tinggi apabila '
                        'air mulai naik.',
                  },
                  {
                    'nama': 'Persiapan Menghadapi Banjir',
                    'lokasi': 'Rumah',
                    'keterangan':
                        'Simpan dokumen penting dan barang berharga '
                        'di tempat yang lebih tinggi serta siapkan '
                        'kebutuhan darurat.',
                  },
                  {
                    'nama': 'Evakuasi Saat Banjir',
                    'lokasi': 'Daerah Terdampak',
                    'keterangan':
                        'Ikuti arahan petugas dan gunakan jalur '
                        'evakuasi yang telah ditentukan.',
                  },
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _daftarBencana(
    BuildContext context,
    List<Map<String, String>> daftar,
  ) {
    return Consumer<BencanaModel>(
      builder: (context, model, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: daftar.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          itemBuilder: (context, index) {
            final data = daftar[index];
            final namaBencana = data['nama']!;

            final sedangDipantau =
                model.sedangDipantau(namaBencana);

            return Card(
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),

                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: Colors.blue,
                    size: 28,
                  ),
                ),

                title: Text(
                  namaBencana,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(data['lokasi']!),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        final provider =
                            context.read<BencanaModel>();

                        if (sedangDipantau) {
                          provider.hapusPantauan(
                            namaBencana,
                          );
                        } else {
                          provider.tambahPantauan(
                            namaBencana,
                          );
                        }
                      },
                      icon: Icon(
                        sedangDipantau
                            ? Icons.star
                            : Icons.star_border,
                        color: sedangDipantau
                            ? Colors.amber
                            : null,
                      ),
                    ),

                    const Icon(Icons.chevron_right),
                  ],
                ),

                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detail,
                    arguments: {
                      'namaBencana': namaBencana,
                      'lokasi': data['lokasi']!,
                      'keterangan': data['keterangan']!,
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
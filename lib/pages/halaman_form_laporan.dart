import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/laporan_model.dart';

class HalamanFormLaporan extends StatefulWidget {
  const HalamanFormLaporan({super.key});

  @override
  State<HalamanFormLaporan> createState() =>
      _HalamanFormLaporanState();
}

class _HalamanFormLaporanState
    extends State<HalamanFormLaporan> {
  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController lokasiController =
      TextEditingController();

  final TextEditingController keteranganController =
      TextEditingController();

  String? jenisBencana;
  bool setujuData = false;
  bool sedangMengirim = false;

  bool get formulirLengkap =>
      namaController.text.trim().isNotEmpty &&
      lokasiController.text.trim().isNotEmpty &&
      keteranganController.text.trim().isNotEmpty &&
      jenisBencana != null &&
      setujuData;

  @override
  void dispose() {
    namaController.dispose();
    lokasiController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  Future<void> kirimLaporan() async {
    if (!formulirLengkap || sedangMengirim) return;

    setState(() {
      sedangMengirim = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    final laporan = LaporanBencana(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      namaPelapor: namaController.text.trim(),
      namaBencana: jenisBencana!,
      lokasi: lokasiController.text.trim(),
      keterangan: keteranganController.text.trim(),
      setujuData: setujuData,
      tanggalLaporan: DateTime.now(),
    );

    context.read<LaporanModel>().tambahLaporan(laporan);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Laporan berhasil dikirim'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan Bencana'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Formulir Laporan Kejadian',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Isi informasi kejadian bencana '
              'yang ingin Anda laporkan.',
            ),

            const SizedBox(height: 24),

            TextField(
              controller: namaController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Nama Pelapor',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: lokasiController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Lokasi Kejadian',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Jenis Bencana',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Gempa Bumi'),
              value: 'Gempa Bumi',
              groupValue: jenisBencana,
              onChanged: (nilai) {
                setState(() {
                  jenisBencana = nilai;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Tsunami'),
              value: 'Tsunami',
              groupValue: jenisBencana,
              onChanged: (nilai) {
                setState(() {
                  jenisBencana = nilai;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Banjir'),
              value: 'Banjir',
              groupValue: jenisBencana,
              onChanged: (nilai) {
                setState(() {
                  jenisBencana = nilai;
                });
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: keteranganController,
              maxLines: 4,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Keterangan Kejadian',
                hintText: 'Jelaskan kondisi kejadian...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 12),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: setujuData,
              title: const Text(
                'Saya menyetujui penggunaan data '
                'untuk keperluan pelaporan bencana',
              ),
              onChanged: (nilai) {
                setState(() {
                  setujuData = nilai ?? false;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    formulirLengkap && !sedangMengirim
                        ? kirimLaporan
                        : null,
                icon: sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  sedangMengirim
                      ? 'Mengirim Laporan...'
                      : 'Kirim Laporan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
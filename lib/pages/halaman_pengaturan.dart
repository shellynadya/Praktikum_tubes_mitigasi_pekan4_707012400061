import 'package:flutter/material.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() =>
      _HalamanPengaturanState();
}

class _HalamanPengaturanState
    extends State<HalamanPengaturan> {
  bool _notifikasiAktif = true;
  bool _modeGelap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pengaturan Aplikasi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Atur preferensi aplikasi Mitigasi+.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          Card(
            child: SwitchListTile(
              secondary: const Icon(
                Icons.notifications_outlined,
              ),
              title: const Text('Notifikasi'),
              subtitle: const Text(
                'Terima informasi dan peringatan bencana.',
              ),
              value: _notifikasiAktif,
              onChanged: (value) {
                setState(() {
                  _notifikasiAktif = value;
                });
              },
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: SwitchListTile(
              secondary: const Icon(
                Icons.dark_mode_outlined,
              ),
              title: const Text('Mode Gelap'),
              subtitle: const Text(
                'Gunakan tampilan gelap pada aplikasi.',
              ),
              value: _modeGelap,
              onChanged: (value) {
                setState(() {
                  _modeGelap = value;
                });
              },
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.location_on_outlined,
              ),
              title: const Text('Wilayah'),
              subtitle: const Text(
                'Kota Palu',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
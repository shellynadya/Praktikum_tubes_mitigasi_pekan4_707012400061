import 'package:flutter/material.dart';

import '../pages/halaman_beranda.dart';
import '../pages/halaman_mitigasi.dart';
import '../pages/halaman_laporan.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  final int indeksAwal;

  const KerangkaNavigasi({
    super.key,
    this.indeksAwal = 0,
  });

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState
    extends State<KerangkaNavigasi> {
  late int _indeksTerpilih;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanMitigasi(),
    HalamanLaporan(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Mitigasi',
    'Laporan',
  ];

  @override
  void initState() {
    super.initState();
    _indeksTerpilih = widget.indeksAwal;
  }

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double lebar = MediaQuery.of(context).size.width;
    final bool layarLebar = lebar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksTerpilih]),
      ),
      drawer: _buatDrawer(),
      body: layarLebar
          ? _tataLetakLebar()
          : _halaman[_indeksTerpilih],
      bottomNavigationBar:
          layarLebar ? null : _buatBilahBawah(),
    );
  }

  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.shield_outlined),
          selectedIcon: Icon(Icons.shield),
          label: 'Mitigasi',
        ),
        NavigationDestination(
          icon: Icon(Icons.report_outlined),
          selectedIcon: Icon(Icons.report),
          label: 'Laporan',
        ),
      ],
    );
  }

  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Beranda'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.shield_outlined),
              selectedIcon: Icon(Icons.shield),
              label: Text('Mitigasi'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.report_outlined),
              selectedIcon: Icon(Icons.report),
              label: Text('Laporan'),
            ),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: _halaman[_indeksTerpilih],
        ),
      ],
    );
  }

  Widget _buatDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.shield,
                  color: Colors.white,
                  size: 42,
                ),
                SizedBox(height: 12),
                Text(
                  'Mitigasi+ Kota Palu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Beranda'),
            onTap: () {
              Navigator.pop(context);
              _pilihTujuan(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shield_outlined),
            title: const Text('Mitigasi'),
            onTap: () {
              Navigator.pop(context);
              _pilihTujuan(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_outlined),
            title: const Text('Laporan'),
            onTap: () {
              Navigator.pop(context);
              _pilihTujuan(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Buat Laporan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                AppRoutes.formLaporan,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Pengaturan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                AppRoutes.pengaturan,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                AppRoutes.tentang,
              );
            },
          ),
        ],
      ),
    );
  }
}
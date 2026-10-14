import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/bencana_model.dart';
import 'model/laporan_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BencanaModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => LaporanModel(),
        ),
      ],
      child: const MitigasiApp(),
    ),
  );
}

class MitigasiApp extends StatelessWidget {
  const MitigasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mitigasi+ Kota Palu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.beranda,
      routes: AppRoutes.daftarRoute(),
      onGenerateRoute: AppRoutes.bentukRoute,
      onUnknownRoute: AppRoutes.routeTidakDikenal,
    );
  }
}
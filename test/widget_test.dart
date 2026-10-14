import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:tubes_mitigasi_pekan4_707012400061/main.dart';
import 'package:tubes_mitigasi_pekan4_707012400061/model/bencana_model.dart';
import 'package:tubes_mitigasi_pekan4_707012400061/model/laporan_model.dart';

void main() {
  testWidgets('Aplikasi Mitigasi+ berhasil dibuka', (tester) async {
    await tester.pumpWidget(
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

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
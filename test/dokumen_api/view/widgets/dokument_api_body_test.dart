// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/dokument_api/dokument_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DokumentApiBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        Provider(
          create: (context) => ChangeNotifierProvider(create: (_) => DokumentApiNotifier()),
          child: MaterialApp(home: DokumentApiBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

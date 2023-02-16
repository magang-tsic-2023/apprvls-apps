// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/dokument_api/dokument_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DokumentApiPage', () {
    group('route', () {
      test('is routable', () {
        expect(DokumentApiPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders DokumentApiView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: DokumentApiPage()));
      expect(find.byType(DokumentApiView), findsOneWidget);
    });
  });
}

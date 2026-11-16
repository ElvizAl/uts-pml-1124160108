import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:soal2_profil_app/main.dart';

void main() {
  testWidgets('Menampilkan halaman login dan validasi kolom kosong',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProfilApp());

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Selamat Datang'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));

    await tester.tap(find.widgetWithText(FilledButton, 'Masuk'));
    await tester.pump();

    expect(find.text('Email wajib diisi'), findsOneWidget);
    expect(find.text('Password wajib diisi'), findsOneWidget);
  });
}

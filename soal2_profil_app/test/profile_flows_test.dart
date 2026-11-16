import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soal2_profil_app/main.dart';
import 'package:soal2_profil_app/models/profile.dart';
import 'package:soal2_profil_app/screens/edit_profile_page.dart';
import 'package:soal2_profil_app/screens/login_page.dart';
import 'package:soal2_profil_app/screens/profile_page.dart';
import 'package:soal2_profil_app/widgets/profile_text_field.dart';

Finder field(String label) => find.descendant(
  of: find.byWidgetPredicate(
    (widget) => widget is ProfileTextField && widget.label == label,
  ),
  matching: find.byType(TextFormField),
);

Future<void> enter(WidgetTester tester, String label, String value) async {
  await tester.ensureVisible(field(label));
  await tester.pumpAndSettle();
  await tester.enterText(field(label), value);
  await tester.pump();
}

Future<void> tapText(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text));
  await tester.pumpAndSettle();
  await tester.tap(find.text(text));
  await tester.pump();
}

Future<void> login(WidgetTester tester) async {
  await tester.pumpWidget(const ProfilApp());
  await enter(tester, 'Email', 'elvis@gmail.com');
  await enter(tester, 'Password', '123456');
  await tapText(tester, 'Masuk');
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  expect(find.byType(ProfilePage), findsOneWidget);
  expect(find.byType(LoginPage), findsNothing);
}

void main() {
  testWidgets('Login menolak format salah dan kredensial salah', (
    tester,
  ) async {
    await tester.pumpWidget(const ProfilApp());
    await enter(tester, 'Email', 'bukan-email');
    await enter(tester, 'Password', '123');
    await tapText(tester, 'Masuk');
    expect(find.text('Format email tidak valid'), findsOneWidget);
    expect(find.text('Password minimal 6 karakter'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await enter(tester, 'Email', 'salah@example.com');
    await enter(tester, 'Password', '123456');
    await tapText(tester, 'Masuk');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Email atau password salah'), findsOneWidget);
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Login, tema, navigasi, simpan dan batal pada ukuran ponsel', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await login(tester);
    expect(
      tester.state<NavigatorState>(find.byType(Navigator)).canPop(),
      isFalse,
    );
    expect(find.byType(CircleAvatar), findsOneWidget);

    await tester.tap(find.byTooltip('Aktifkan tema gelap'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    await tapText(tester, 'Tentang Saya');
    await tester.pumpAndSettle();
    expect(find.text('Keahlian & Hobi'), findsOneWidget);
    expect(find.text('Pengembangan Aplikasi'), findsOneWidget);
    expect(find.text('Desain Digital'), findsOneWidget);
    expect(find.text('Kecerdasan Buatan'), findsOneWidget);
    await tester.ensureVisible(find.text('Riwayat Pendidikan'));
    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsNothing);
    await tester.tap(find.byTooltip('Aktifkan tema terang'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
    await tapText(tester, 'Profil');
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Edit Profil'));
    await tester.pumpAndSettle();
    final original = tester
        .widget<TextFormField>(field('Nama lengkap'))
        .controller!
        .text;
    await enter(tester, 'Nama lengkap', 'Nama Uji');
    await enter(tester, 'Email', 'uji@example.com');
    await enter(tester, 'Nomor HP', '0812345678');
    await tapText(tester, 'Simpan Perubahan');
    await tester.pumpAndSettle();
    expect(find.byType(EditProfilePage), findsNothing);
    expect(find.text('Nama Uji'), findsOneWidget);
    await tester.ensureVisible(find.text('uji@example.com'));
    expect(find.text('0812345678'), findsOneWidget);

    // Tunggu pesan sukses selesai agar tidak menutupi tombol Batal pada rute baru.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Edit Profil'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextFormField>(field('Nama lengkap')).controller!.text,
      'Nama Uji',
    );
    await enter(tester, 'Nama lengkap', original);
    await tapText(tester, 'Batal');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Nama Uji'));
    expect(find.text('Nama Uji'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Edit memvalidasi nama, email, batas HP dan menyaring huruf', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    const profile = Profile(
      name: 'Uji',
      nim: '1',
      prodi: 'TI',
      kelas: 'A',
      bio: 'Bio',
      email: 'uji@example.com',
      hp: '081234567890',
      github: 'uji',
    );
    await tester.pumpWidget(
      const MaterialApp(home: EditProfilePage(profile: profile)),
    );
    await enter(tester, 'Nama lengkap', '   ');
    await enter(tester, 'Email', 'salah');
    await tapText(tester, 'Simpan Perubahan');
    expect(find.text('Nama wajib diisi'), findsOneWidget);
    expect(find.text('Format email tidak valid'), findsOneWidget);
    expect(find.byType(EditProfilePage), findsOneWidget);
    for (final hp in ['', '123456789', '12345678901234']) {
      await enter(tester, 'Nomor HP', hp);
      expect(
        find.text('Nomor HP harus terdiri dari 10–13 digit'),
        findsOneWidget,
      );
    }
    for (final hp in ['1234567890', '1234567890123']) {
      await enter(tester, 'Nomor HP', hp);
      expect(
        find.text('Nomor HP harus terdiri dari 10–13 digit'),
        findsNothing,
      );
    }
    await enter(tester, 'Nomor HP', 'abc0812345678xyz');
    expect(
      tester.widget<TextFormField>(field('Nomor HP')).controller!.text,
      '0812345678',
    );
    expect(tester.takeException(), isNull);
  });
}

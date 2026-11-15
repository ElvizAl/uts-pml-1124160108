import 'package:flutter/material.dart';

import 'screens/login_page.dart';
import 'screens/profile_page.dart';

void main() {
  runApp(const ProfilApp());
}

class ProfilApp extends StatefulWidget {
  const ProfilApp({super.key});

  @override
  State<ProfilApp> createState() => _ProfilAppState();
}

class _ProfilAppState extends State<ProfilApp> {
  final ValueNotifier<bool> _isDark = ValueNotifier(false);

  @override
  void dispose() {
    _isDark.dispose();
    super.dispose();
  }

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: brightness,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }

  void _toggleTheme() {
    _isDark.value = !_isDark.value;
  }

  Widget _buildProfile(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDark,
      builder: (context, isDark, child) {
        return ProfilePage(
          isDark: isDark,
          onThemeChanged: _toggleTheme,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDark,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'Profil Elvis',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: LoginPage(
            profileBuilder: _buildProfile,
          ),
        );
      },
    );
  }
}
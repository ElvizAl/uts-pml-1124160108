import 'package:flutter/material.dart';

import '../widgets/info_tile.dart';
import '../widgets/section_title.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SectionTitle(
          title: 'Keahlian & Hobi',
        ),
        Card(
          child: Column(
            children: [
              InfoTile(
                icon: Icons.phone_android,
                title: 'Pengembangan Aplikasi',
                value: 'Mempelajari pembuatan aplikasi menggunakan Flutter.',
              ),
              InfoTile(
                icon: Icons.palette_outlined,
                title: 'Desain Digital',
                value: 'Membuat desain dan mengolah gambar.',
              ),
              InfoTile(
                icon: Icons.smart_toy_outlined,
                title: 'Kecerdasan Buatan',
                value: 'Mempelajari chatbot dan otomatisasi berbasis AI.',
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        SectionTitle(
          title: 'Riwayat Pendidikan',
        ),
        Card(
          child: Column(
            children: [
              InfoTile(
                icon: Icons.school_outlined,
                title: 'SMA / SMK',
                value: 'SMK N 2 SONGGOM.',
              ),
              InfoTile(
                icon: Icons.account_balance_outlined,
                title: 'Perguruan Tinggi',
                value: 'Global Institute.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
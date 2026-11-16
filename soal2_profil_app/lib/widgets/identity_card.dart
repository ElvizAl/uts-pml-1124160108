import 'package:flutter/material.dart';

import 'info_tile.dart';

class IdentityCard extends StatelessWidget {
  final String nim;
  final String prodi;
  final String kelas;

  const IdentityCard({
    super.key,
    required this.nim,
    required this.prodi,
    required this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InfoTile(
            icon: Icons.badge_outlined,
            title: 'NIM',
            value: nim,
          ),
          InfoTile(
            icon: Icons.school_outlined,
            title: 'Program Studi',
            value: prodi,
          ),
          InfoTile(
            icon: Icons.groups_outlined,
            title: 'Kelas',
            value: kelas,
          ),
        ],
      ),
    );
  }
}
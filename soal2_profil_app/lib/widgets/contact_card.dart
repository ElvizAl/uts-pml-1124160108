import 'package:flutter/material.dart';

import 'info_tile.dart';

class ContactCard extends StatelessWidget {
  final String email;
  final String hp;
  final String github;

  const ContactCard({
    super.key,
    required this.email,
    required this.hp,
    required this.github,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InfoTile(
            icon: Icons.email_outlined,
            title: 'Email',
            value: email,
          ),
          InfoTile(
            icon: Icons.phone_outlined,
            title: 'Nomor HP',
            value: hp,
          ),
          InfoTile(
            icon: Icons.code,
            title: 'GitHub',
            value: github,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String nama;
  final String bio;
  final String imagePath;

  const ProfileHeader({
    super.key,
    required this.nama,
    required this.bio,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          nama,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          bio,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
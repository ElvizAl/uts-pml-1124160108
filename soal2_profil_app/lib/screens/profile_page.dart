import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../widgets/contact_card.dart';
import '../widgets/identity_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_title.dart';
import 'about_page.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeChanged;

  const ProfilePage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  Profile _profile = const Profile(
    nama: 'Elvis al-amsory',
    nim: '1124160108',
    prodi: 'Teknik Informatika',
    kelas: 'TI SE M 24',
    bio: 'Saya tertarik pada pengembangan aplikasi dan teknologi AI.',
    email: 'elvis@gmail.com',
    hp: '083861332776',
    github: 'ElvizAl',
  );
}
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
    name: 'Elvis al - amsory',
    nim: '1124160108',
    prodi: 'Teknik Informatika',
    kelas: 'TI- SE M 24',
    bio: 'Saya tertarik pada pengembangan aplikasi dan teknologi AI.',
    email: 'elvis@example.com',
    hp: '081234567890',
    github: 'ElvizAl',
  );

  Future<void> _editProfile() async {
    final updatedProfile = await Navigator.push<Profile>(
      context,
      MaterialPageRoute<Profile>(
        builder: (context) {
          return EditProfilePage(profile: _profile);
        },
      ),
    );

    if (!mounted || updatedProfile == null) return;

    setState(() {
      _profile = updatedProfile;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Profil Mahasiswa' : 'Tentang Saya',
        ),
        actions: [
          IconButton(
            tooltip: widget.isDark
                ? 'Aktifkan tema terang'
                : 'Aktifkan tema gelap',
            onPressed: widget.onThemeChanged,
            icon: Icon(
              widget.isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
              children: [
                ProfileHeader(
                  nama: _profile.name,
                  bio: _profile.bio,
                  imagePath: 'assets/images/profil.jpg',
                ),
                const SizedBox(height: 24),
                const SectionTitle(
                  title: 'Identitas Mahasiswa',
                ),
                IdentityCard(
                  nim: _profile.nim,
                  prodi: _profile.prodi,
                  kelas: _profile.kelas,
                ),
                const SizedBox(height: 20),
                const SectionTitle(
                  title: 'Kontak',
                ),
                ContactCard(
                  email: _profile.email,
                  hp: _profile.hp,
                  github: _profile.github,
                ),
              ],
            ),
            const AboutPage(),
          ],
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _editProfile,
              tooltip: 'Edit Profil',
              child: const Icon(Icons.edit_outlined),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
            label: 'Tentang Saya',
          ),
        ],
      ),
    );
  }
}
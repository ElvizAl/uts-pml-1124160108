import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/profile.dart';
import '../widgets/profile_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nama;
  late final TextEditingController _nim;
  late final TextEditingController _prodi;
  late final TextEditingController _kelas;
  late final TextEditingController _bio;
  late final TextEditingController _email;
  late final TextEditingController _hp;
  late final TextEditingController _github;

  @override
  void initState() {
    super.initState();

    final profile = widget.profile;

    _nama = TextEditingController(text: profile.name);
    _nim = TextEditingController(text: profile.nim);
    _prodi = TextEditingController(text: profile.prodi);
    _kelas = TextEditingController(text: profile.kelas);
    _bio = TextEditingController(text: profile.bio);
    _email = TextEditingController(text: profile.email);
    _hp = TextEditingController(text: profile.hp);
    _github = TextEditingController(text: profile.github);
  }

  @override
  void dispose() {
    _nama.dispose();
    _nim.dispose();
    _prodi.dispose();
    _kelas.dispose();
    _bio.dispose();
    _email.dispose();
    _hp.dispose();
    _github.dispose();

    super.dispose();
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    final updatedProfile = Profile(
      name: _nama.text.trim(),
      nim: _nim.text.trim(),
      prodi: _prodi.text.trim(),
      kelas: _kelas.text.trim(),
      bio: _bio.text.trim(),
      email: _email.text.trim(),
      hp: _hp.text.trim(),
      github: _github.text.trim(),
    );

    Navigator.pop(context, updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProfileTextField(
                controller: _nama,
                label: 'Nama lengkap',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }

                  return null;
                },
              ),
              ProfileTextField(
                controller: _nim,
                label: 'NIM',
                icon: Icons.badge_outlined,
              ),
              ProfileTextField(
                controller: _prodi,
                label: 'Program studi',
                icon: Icons.school_outlined,
              ),
              ProfileTextField(
                controller: _kelas,
                label: 'Kelas',
                icon: Icons.groups_outlined,
              ),
              ProfileTextField(
                controller: _bio,
                label: 'Bio singkat',
                icon: Icons.description_outlined,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              ProfileTextField(
                controller: _email,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  final email = value?.trim() ?? '';

                  if (email.isEmpty) {
                    return 'Email wajib diisi';
                  }

                  final pattern = RegExp(
                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                  );

                  if (!pattern.hasMatch(email)) {
                    return 'Format email tidak valid';
                  }

                  return null;
                },
              ),
              ProfileTextField(
                controller: _hp,
                label: 'Nomor HP',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  final hp = value?.trim() ?? '';

                  if (!RegExp(r'^[0-9]{10,13}$').hasMatch(hp)) {
                    return 'Nomor HP harus terdiri dari 10–13 digit';
                  }

                  return null;
                },
              ),
              ProfileTextField(
                controller: _github,
                label: 'Akun GitHub',
                icon: Icons.code,
              ),
              FilledButton.icon(
                onPressed: _saveProfile,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan Perubahan'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Batal'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
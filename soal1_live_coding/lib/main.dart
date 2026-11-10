import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Elvis Al-Amsory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 55),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Elvis Al-Amsory',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'NIM: 1124160108',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Teknik Informatika',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  const Card(
                    child: Column(
                      children: [
                        InfoTile(
                          icon: Icons.email,
                          label: 'Email',
                          value: '1124160108@global.ac.id',
                        ),
                        InfoTile(
                          icon: Icons.phone,
                          label: 'Nomor HP',
                          value: '083861332776',
                        ),
                        InfoTile(
                          icon: Icons.class_,
                          label: 'Kelas',
                          value: 'TISE 24 Malam',
                        ),
                        InfoTile(
                          icon: Icons.code,
                          label: 'GitHub',
                          value: 'github.com/ElvizAl',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Card(
                    child: Column(
                      children: [
                        InfoTile(
                          icon: Icons.computer,
                          label: 'Keahlian',
                          value: 'Tidur',
                        ),
                        InfoTile(
                          icon: Icons.sports_esports,
                          label: 'Hobi',
                          value: 'Gaming',
                        ),
                        InfoTile(
                          icon: Icons.music_note,
                          label: 'Hobi',
                          value: 'Musik',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}

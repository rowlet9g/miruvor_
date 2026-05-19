import 'package:flutter/material.dart';
import 'package:miruvor/app/theme.dart';
import 'package:miruvor/features/home/presentation/home_shell.dart';

class MiruvorApp extends StatelessWidget {
  const MiruvorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miruvor',
      debugShowCheckedModeBanner: false,
      theme: buildMiruvorTheme(),
      home: const HomeShell(),
    );
  }
}

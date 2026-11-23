import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/app_shell.dart';
import 'state/sinalmundo_controller.dart';

class SinalMundoApp extends StatelessWidget {
  const SinalMundoApp({super.key, required this.controller});

  final SinalMundoController controller;

  @override
  Widget build(BuildContext context) {
    return SinalMundoScope(
      controller: controller,
      child: MaterialApp(
        title: 'SinalMundo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const AppShell(),
      ),
    );
  }
}

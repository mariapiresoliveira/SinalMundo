import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/sign_entry.dart';
import '../../services/vlibras_demo_launcher.dart';

/// Abre uma página com o termo preparado para tradução no Widget oficial.
class VlibrasDemoButton extends StatelessWidget {
  const VlibrasDemoButton({super.key, required this.entry, this.expanded = true});

  final SignEntry entry;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton.icon(
      onPressed: () {
        final opened = openVlibrasDemo(entry);
        if (!opened) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('O Widget está disponível na versão Web. No navegador, permita pop-ups e tente novamente.'),
              ),
            );
        }
      },
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: const Icon(Icons.play_circle_fill_rounded),
      label: const Text('Preparar termo no VLibras 3D'),
    );
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

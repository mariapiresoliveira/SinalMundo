import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../services/vlibras_demo_launcher.dart';

/// Abre uma página com uma frase ou trecho preparado para tradução no Widget.
class VlibrasTextDemoButton extends StatelessWidget {
  const VlibrasTextDemoButton({
    super.key,
    required this.text,
    this.label = 'Preparar trecho no VLibras',
    this.category = 'História criada',
    this.expanded = true,
  });

  final String text;
  final String label;
  final String category;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton.icon(
      onPressed: text.trim().isEmpty
          ? null
          : () {
              final opened = openVlibrasTextDemo(text, category: category);
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
      icon: const Icon(Icons.sign_language_rounded),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.purpleDark,
        side: const BorderSide(color: AppColors.purple),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

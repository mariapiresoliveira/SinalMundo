import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/sign_entry.dart';

/// Espaço visual associado ao termo.
/// Não simula gestos: a demonstração específica fica pendente até existir mídia
/// validada por pessoas fluentes em Libras e educadores bilíngues.
class SignDemo2D extends StatelessWidget {
  const SignDemo2D({super.key, required this.entry, this.compact = false});

  final SignEntry entry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Semantics(
        label: 'Demonstração específica pendente para ${entry.term}',
        child: Container(
          width: 52,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.paleBlue,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFD7E8F1)),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.blueDark,
            size: 27,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.paleBlue, AppColors.lavender],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 66,
            height: 66,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 39,
              color: AppColors.purple,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Demonstração específica pendente',
                  style: TextStyle(
                    color: AppColors.purpleDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'O registro “${entry.term}” tem os parâmetros transcritos, mas ainda não possui vídeo ou animação do gesto validado. Nenhum movimento foi inventado.',
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF2D6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'AGUARDANDO VALIDAÇÃO',
                    style: TextStyle(
                      color: Color(0xFF825D16),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

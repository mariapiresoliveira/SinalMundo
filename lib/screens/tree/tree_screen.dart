import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../state/sinalmundo_controller.dart';
import '../../widgets/section_title.dart';

class TreeScreen extends StatelessWidget {
  const TreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SinalMundoScope.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Árvore da Comunicação',
                        subtitle:
                            'Cada sinal conhecido, história lida e tema explorado ajuda sua árvore a crescer.',
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE8F8E7), Color(0xFFFFF7DD)],
                          ),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Column(
                          children: [
                            _TreeIllustration(stage: _treeStage(controller)),
                            const SizedBox(height: 6),
                            Text(
                              _stageText(controller),
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                color: AppColors.purpleDark,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Seu mundo de sinais cresce com você.',
                              style: TextStyle(color: AppColors.muted),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Etapas do crescimento',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const _StageRow(
                        emoji: '🌱',
                        title: 'Broto',
                        description: 'Início do contato com um tema.',
                        complete: true,
                      ),
                      _StageRow(
                        emoji: '🍃',
                        title: 'Folhas',
                        description: 'Novos sinais conhecidos.',
                        complete: controller.signsViewed > 0,
                      ),
                      _StageRow(
                        emoji: '🍎',
                        title: 'Frutos',
                        description: 'Histórias contextualizadas e concluídas.',
                        complete: controller.completedStories > 0,
                      ),
                      _StageRow(
                        emoji: '🦋',
                        title: 'Borboletas',
                        description: 'Novos elementos surgem ao explorar temas.',
                        complete: controller.completedTopics >= 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  int _treeStage(SinalMundoController controller) {
    if (controller.completedTopics > 0) return 3;
    if (controller.completedStories > 0) return 2;
    if (controller.signsViewed > 0) return 1;
    return 0;
  }

  String _stageText(SinalMundoController controller) {
    if (controller.completedTopics > 0) {
      return 'Sua árvore já tem novas borboletas!';
    }
    if (controller.completedStories > 0) {
      return 'Sua árvore começou a dar frutos!';
    }
    if (controller.signsViewed > 0) {
      return 'Novas folhas estão surgindo!';
    }
    return 'Um broto cheio de possibilidades!';
  }
}

class _TreeIllustration extends StatelessWidget {
  const _TreeIllustration({required this.stage});

  final int stage;

  @override
  Widget build(BuildContext context) {
    final plant = switch (stage) {
      0 => '🌱',
      1 => '🌿',
      _ => '🌳',
    };

    return SizedBox(
      width: 280,
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 8,
            child: Container(
              width: 245,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFFB6D77A),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Text(
                plant,
                key: ValueKey(stage),
                style: TextStyle(fontSize: stage == 0 ? 112 : stage == 1 ? 140 : 165),
              ),
            ),
          ),
          if (stage >= 2) ...[
            const Positioned(
              bottom: 142,
              left: 83,
              child: Text('🍎', style: TextStyle(fontSize: 25)),
            ),
            const Positioned(
              bottom: 164,
              right: 82,
              child: Text('🍐', style: TextStyle(fontSize: 23)),
            ),
          ],
          if (stage >= 3) ...[
            const Positioned(
              top: 13,
              left: 42,
              child: Text('🦋', style: TextStyle(fontSize: 29)),
            ),
            const Positioned(
              top: 37,
              right: 36,
              child: Text('🦋', style: TextStyle(fontSize: 24)),
            ),
          ],
        ],
      ),
    );
  }

}

class _StageRow extends StatelessWidget {
  const _StageRow({
    required this.emoji,
    required this.title,
    required this.description,
    required this.complete,
  });

  final String emoji;
  final String title;
  final String description;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            complete ? Icons.check_circle_rounded : Icons.lock_outline_rounded,
            color: complete ? AppColors.green : AppColors.muted,
          ),
        ],
      ),
    );
  }
}

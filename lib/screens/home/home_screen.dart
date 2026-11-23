import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/demo_data.dart';
import '../../state/sinalmundo_controller.dart';
import '../../widgets/milo_avatar.dart';
import '../../widgets/module_card.dart';
import '../../widgets/section_title.dart';
import '../stories/stories_screen.dart';
import '../signs/sign_catalog_screen.dart';
import '../stories/story_creator_screen.dart';
import '../world/world_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SinalMundoScope.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1250),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TopBar(
                      xp: controller.xp,
                      level: controller.level,
                      signsViewed: controller.signsViewed,
                    ),
                    const SizedBox(height: 22),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final wide = constraints.maxWidth > 780;
                        final hero = _WelcomePanel();
                        final tree = _TreePanel(
                          progress: (controller.completedStories /
                                  (DemoData.stories.length + controller.createdStories.length))
                              .clamp(0.0, 1.0)
                              .toDouble(),
                        );

                        if (wide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(flex: 6, child: hero),
                              const SizedBox(width: 16),
                              Expanded(flex: 5, child: tree),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            hero,
                            const SizedBox(height: 14),
                            tree,
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(
                      title: 'Vamos aprender juntos?',
                      subtitle:
                          'Escolha uma aventura para continuar explorando.',
                    ),
                    const SizedBox(height: 13),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final count = constraints.maxWidth > 980
                            ? 4
                            : constraints.maxWidth > 560
                                ? 2
                                : 1;

                        return GridView.count(
                          crossAxisCount: count,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 13,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: switch (count) {
                            1 => 1.7,
                            2 => 1.75,
                            _ => 1.42,
                          },
                          children: [
                            ModuleCard(
                              title: 'Mundo Vivo',
                              description:
                                  'Explore dez áreas temáticas e descubra sinais em situações do cotidiano.',
                              emoji: '🗺️',
                              color: AppColors.green,
                              badge: 'Explorar',
                              onTap: () => _go(context, 1),
                            ),
                            ModuleCard(
                              title: 'Catálogo de Sinais',
                              description:
                                  'Pesquise termos por tema e consulte fichas de sinais em preparação.',
                              emoji: '🤟',
                              color: AppColors.purple,
                              badge: 'Consultar',
                              onTap: () => _go(context, 2),
                            ),
                            ModuleCard(
                              title: 'Biblioteca de Histórias',
                              description:
                                  'Leia histórias curtas e descubra Libras em situações do cotidiano.',
                              emoji: '📚',
                              color: AppColors.blueDark,
                              badge: 'Ler',
                              onTap: () => _go(context, 3),
                            ),
                            ModuleCard(
                              title: 'Criador de Histórias',
                              description:
                                  'Escreva qualquer história e descubra os sinais correspondentes em cada trecho.',
                              emoji: '📘',
                              color: AppColors.green,
                              badge: 'Criar',
                              onTap: () => _go(context, 4),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(
                      title: 'Sua jornada',
                      subtitle:
                          'O progresso aparece na Árvore da Comunicação.',
                    ),
                    const SizedBox(height: 12),
                    _JourneyRow(
                      signs: controller.signsViewed,
                      stories: controller.completedStories,
                      totalStories: DemoData.stories.length + controller.createdStories.length,
                      topics: controller.completedTopics,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _go(BuildContext context, int index) {
    final Widget page = switch (index) {
      1 => const WorldScreen(),
      2 => const SignCatalogScreen(),
      3 => const StoriesScreen(),
      4 => const StoryCreatorScreen(),
      _ => const WorldScreen(),
    };

    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.xp,
    required this.level,
    required this.signsViewed,
  });

  final int xp;
  final int level;
  final int signsViewed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 12,
      spacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MiloAvatar(size: 58),
            SizedBox(width: 11),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SINALMUNDO',
                  style: TextStyle(
                    color: AppColors.purpleDark,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontSize: 19,
                  ),
                ),
                Text(
                  'O mundo ensina Libras',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _MetricPill(
              icon: Icons.stars_rounded,
              label: 'Nível $level',
              color: AppColors.yellow,
            ),
            _MetricPill(
              icon: Icons.bolt_rounded,
              label: '$xp XP',
              color: AppColors.blue,
            ),
            _MetricPill(
              icon: Icons.waving_hand_rounded,
              label: '$signsViewed/90 sinais',
              color: AppColors.green,
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 29,
            height: 29,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(.24),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: AppColors.purpleDark),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEDE8FF), Color(0xFFE2F6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Olá, explorador!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: AppColors.purpleDark,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cada descoberta abre um novo mundo. Vamos aprender Libras em situações do nosso dia a dia?',
                  style: TextStyle(height: 1.4, color: AppColors.ink),
                ),
                SizedBox(height: 13),
                Text(
                  '🤟  Situação  →  Imagem  →  Contexto  →  Sinal',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blueDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const MiloAvatar(size: 94),
        ],
      ),
    );
  }
}

class _TreePanel extends StatelessWidget {
  const _TreePanel({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E8),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFFFE5A8), width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Árvore da Comunicação',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.purpleDark,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Sua árvore cresce a cada nova descoberta.',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.white,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${(progress * 100).round()}% da jornada de histórias',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Text('🌳', style: TextStyle(fontSize: 70)),
        ],
      ),
    );
  }
}

class _JourneyRow extends StatelessWidget {
  const _JourneyRow({
    required this.signs,
    required this.stories,
    required this.totalStories,
    required this.topics,
  });

  final int signs;
  final int stories;
  final int totalStories;
  final int topics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 520 ? 2 : 3;
        final itemWidth = (constraints.maxWidth - (columns - 1) * 9) / columns;
        return Wrap(
          spacing: 9,
          runSpacing: 9,
          children: [
            SizedBox(
              width: itemWidth,
              child: _JourneyMetric(emoji: '🤟', title: 'Sinais vistos', value: '$signs/90'),
            ),
            SizedBox(
              width: itemWidth,
              child: _JourneyMetric(emoji: '🍎', title: 'Histórias', value: '$stories/$totalStories'),
            ),
            SizedBox(
              width: itemWidth,
              child: _JourneyMetric(emoji: '🦋', title: 'Temas', value: '$topics/10'),
            ),
          ],
        );
      },
    );
  }
}

class _JourneyMetric extends StatelessWidget {
  const _JourneyMetric({
    required this.emoji,
    required this.title,
    required this.value,
  });

  final String emoji;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: AppColors.ink,
              fontSize: 17,
            ),
          ),
          Text(title, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/demo_data.dart';
import '../../models/story.dart';
import '../../state/sinalmundo_controller.dart';
import '../../widgets/section_title.dart';
import 'story_reader_screen.dart';
import 'story_creator_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SinalMundoScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1050),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final createButton = FilledButton.icon(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const StoryCreatorScreen()),
                        ),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Criar história'),
                      );
                      if (constraints.maxWidth < 560) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionTitle(
                              title: 'Biblioteca de Histórias',
                              subtitle: 'Leia narrativas prontas ou crie uma aventura com suas próprias palavras.',
                            ),
                            const SizedBox(height: 10),
                            Align(alignment: Alignment.centerRight, child: createButton),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          const Expanded(
                            child: SectionTitle(
                              title: 'Biblioteca de Histórias',
                              subtitle: 'Leia narrativas prontas ou crie uma aventura com suas próprias palavras.',
                            ),
                          ),
                          const SizedBox(width: 12),
                          createButton,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      final allStories = <Story>[
                        ...controller.createdStories,
                        ...DemoData.stories,
                      ];
                      final total = allStories.length;
                      final completed = controller.completedStories;
                      final progress = total == 0 ? 0.0 : (completed / total).clamp(0.0, 1.0);
                      return Column(children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(children: [
                            const Text('📚', style: TextStyle(fontSize: 26)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text('$completed de $total histórias concluídas',
                                  style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.purpleDark)),
                            ),
                            Text('${(progress * 100).round()}%',
                                style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.green)),
                          ]),
                        ),
                        const SizedBox(height: 15),
                        LayoutBuilder(builder: (context, constraints) {
                          final cols = constraints.maxWidth > 760 ? 2 : 1;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allStories.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: cols,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 13,
                              childAspectRatio: cols == 2
                                  ? 2.55
                                  : constraints.maxWidth < 460
                                      ? 2.3
                                      : 3.35,
                            ),
                            itemBuilder: (context, i) {
                              final story = allStories[i];
                              return _StoryTile(
                                story: story,
                                done: controller.hasReadStory(story.id),
                                custom: !DemoData.stories.any((item) => item.id == story.id),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute<void>(builder: (_) => StoryReaderScreen(story: story)),
                                ),
                              );
                            },
                          );
                        }),
                      ]);
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'As histórias criadas ficam na biblioteca durante esta sessão. Os trechos podem ser enviados ao Widget VLibras; os termos reconhecidos no catálogo abrem suas fichas, com o estado de validação sempre indicado.',
                    style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.4),
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

class _StoryTile extends StatelessWidget {
  const _StoryTile({required this.story, required this.done, required this.custom, required this.onTap});
  final Story story;
  final bool done;
  final bool custom;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        elevation: 1,
        shadowColor: AppColors.purpleDark.withOpacity(.05),
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), border: Border.all(color: AppColors.border)),
            child: Row(children: [
              Container(
                width: 72,
                height: 82,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF79C9F1), Color(0xFF398CD4)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(story.emoji, style: const TextStyle(fontSize: 37)),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      story.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.ink),
                    ),
                    const SizedBox(height: 5),
                    Text(story.summary, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, height: 1.3, color: AppColors.muted)),
                    const SizedBox(height: 7),
                    Row(children: [
                      Icon(done ? Icons.check_circle_rounded : (custom ? Icons.auto_awesome_rounded : Icons.menu_book_rounded),
                          size: 15, color: done ? AppColors.green : AppColors.blueDark),
                      const SizedBox(width: 5),
                      Text(done ? 'Concluída' : (custom ? 'Criada por você' : '${story.pages.length} páginas'),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: done ? AppColors.green : AppColors.blueDark)),
                    ]),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
            ]),
          ),
        ),
      );
}

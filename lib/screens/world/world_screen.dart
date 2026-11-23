import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/demo_data.dart';
import '../../data/sign_catalog_data.dart';
import '../../models/topic.dart';
import '../../state/sinalmundo_controller.dart';
import '../../widgets/section_title.dart';
import '../signs/sign_detail_screen.dart';

class WorldScreen extends StatelessWidget {
  const WorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SinalMundoScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    title: 'Mundo Vivo',
                    subtitle: 'Escolha um ambiente e descubra palavras do cotidiano.',
                  ),
                  const SizedBox(height: 13),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.paleBlue,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFD8EAF4)),
                    ),
                    child: const Row(
                      children: [
                        Text('🧭', style: TextStyle(fontSize: 29)),
                        SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            'Dez áreas temáticas conectam situações, palavras e o catálogo de Libras. Toque em uma área para explorar.',
                            style: TextStyle(
                              color: AppColors.blueDark,
                              fontWeight: FontWeight.w700,
                              height: 1.4,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth > 900
                          ? 5
                          : constraints.maxWidth > 620
                              ? 3
                              : 2;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: DemoData.topics.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: constraints.maxWidth > 900
                              ? 1.12
                              : constraints.maxWidth > 620
                                  ? 1.48
                                  : constraints.maxWidth < 360
                                      ? 1.0
                                      : 1.42,
                        ),
                        itemBuilder: (context, index) {
                          final topic = DemoData.topics[index];
                          return _TopicTile(
                            topic: topic,
                            onTap: () => _openTopic(context, topic, controller),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Os termos com correspondência direta no catálogo abrem uma ficha com os cinco parâmetros do manual. A demonstração específica do gesto permanece identificada como pendente até ser validada.',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      height: 1.45,
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

  void _openTopic(
    BuildContext context,
    Topic topic,
    SinalMundoController controller,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        final maxSheetHeight = MediaQuery.of(sheetContext).size.height * .82;
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxSheetHeight),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: topic.color.withOpacity(.13),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(topic.emoji, style: const TextStyle(fontSize: 32)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topic.title,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                color: AppColors.ink,
                              ),
                            ),
                            Text(topic.subtitle, style: const TextStyle(color: AppColors.muted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (controller.hasExploredTopic(topic.id))
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.mint,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded, size: 15, color: AppColors.green),
                          SizedBox(width: 6),
                          Text('Tema já explorado', style: TextStyle(color: AppColors.green, fontSize: 11, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                  const SizedBox(height: 12),
                  const Text(
                    'Palavras deste tema',
                    style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink),
                  ),
                  const SizedBox(height: 9),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: topic.words.map((word) {
                      final matches = SignCatalogData.entries.where(
                        (entry) => entry.categoryId == topic.id && entry.term == word,
                      );
                      final entry = matches.isEmpty ? null : matches.first;
                      return ActionChip(
                        avatar: Icon(
                          entry == null ? Icons.text_fields_rounded : Icons.waving_hand_rounded,
                          size: 17,
                        ),
                        label: Text(word),
                        backgroundColor: topic.color.withOpacity(.10),
                        side: BorderSide.none,
                        onPressed: entry == null
                            ? null
                            : () {
                                Navigator.pop(sheetContext);
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => SignDetailScreen(entry: entry),
                                  ),
                                );
                              },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7E4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'As fichas mostram os parâmetros transcritos do manual. A demonstração do gesto só será apresentada quando houver mídia específica validada.',
                      style: TextStyle(fontSize: 12, color: AppColors.ink, height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 13),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: controller.hasExploredTopic(topic.id)
                          ? null
                          : () {
                              final messenger = ScaffoldMessenger.of(context);
                              controller.markTopicExplored(topic.id);
                              Navigator.pop(sheetContext);
                              messenger.showSnackBar(
                                const SnackBar(content: Text('Tema explorado! +50 XP 🌱')),
                              );
                            },
                      icon: const Icon(Icons.check_circle_outline_rounded),
                      label: Text(
                        controller.hasExploredTopic(topic.id)
                            ? 'Tema já explorado'
                            : 'Marcar tema como explorado',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TopicTile extends StatelessWidget {
  const _TopicTile({required this.topic, required this.onTap});

  final Topic topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.purpleDark.withOpacity(.05),
      borderRadius: BorderRadius.circular(21),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(21),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: topic.color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(topic.emoji, style: const TextStyle(fontSize: 43)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                topic.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink),
              ),
              Text(
                topic.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.muted, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

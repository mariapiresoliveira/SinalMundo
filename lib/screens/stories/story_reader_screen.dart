import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/sign_entry.dart';
import '../../models/story.dart';
import '../../services/story_sign_matcher.dart';
import '../../state/sinalmundo_controller.dart';
import '../../widgets/signs/vlibras_demo_button.dart';
import '../../widgets/signs/vlibras_text_demo_button.dart';

class StoryReaderScreen extends StatefulWidget {
  const StoryReaderScreen({super.key, required this.story});
  final Story story;

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final pages = story.pages.isEmpty ? const ['Esta história ainda não possui texto.'] : story.pages;
    final currentPage = page.clamp(0, pages.length - 1).toInt();
    final pageText = pages[currentPage];
    final matches = StorySignMatcher.findInText(pageText);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(story.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF5F0FF), Color(0xFFE8F7FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: Column(children: [
                        Text(story.emoji, style: const TextStyle(fontSize: 60)),
                        const SizedBox(height: 16),
                        Text(story.title, textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.purpleDark)),
                        const SizedBox(height: 18),
                        Text(pageText, textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 19, height: 1.55, color: AppColors.ink)),
                        const SizedBox(height: 18),
                        Text('Trecho ${currentPage + 1} de ${pages.length}',
                            style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 9),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: (currentPage + 1) / pages.length,
                            minHeight: 9,
                            color: AppColors.blueDark,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    const Text('Tradução do trecho completo',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.purpleDark)),
                    const SizedBox(height: 7),
                    VlibrasTextDemoButton(
                      text: pageText,
                      category: 'História: ${story.title}',
                      label: 'Preparar este trecho no VLibras 3D',
                    ),
                    const SizedBox(height: 18),
                    Row(children: [
                      const Expanded(child: Text('Sinais do catálogo encontrados',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.purpleDark))),
                      Text('${matches.length}', style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.w900)),
                    ]),
                    const SizedBox(height: 8),
                    if (matches.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(color: const Color(0xFFFFF5D9), borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          'Este trecho não contém um termo reconhecido no catálogo local. O texto pode ser enviado ao VLibras para tradução automática. Um sinal específico só deve ser ensinado depois de validado.',
                          style: TextStyle(color: AppColors.ink, fontSize: 12, height: 1.4),
                        ),
                      )
                    else
                      ...matches.map((match) => _MatchedSignCard(match: match)),
                    const SizedBox(height: 12),
                    const Text(
                      'A tradução automática pode escolher uma formulação diferente ou não ter correspondência para todos os termos. Confirme o uso contextual e a variante regional com pessoas fluentes em Libras e educadores bilíngues.',
                      style: TextStyle(color: AppColors.muted, fontSize: 11, height: 1.4),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: currentPage == 0 ? null : () => setState(() => page = currentPage - 1),
                      child: const Text('Anterior'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (currentPage < pages.length - 1) {
                          setState(() => page = currentPage + 1);
                        } else {
                          final messenger = ScaffoldMessenger.of(context);
                          final earnedXp =
                              SinalMundoScope.of(context).completeStory(story.id);
                          Navigator.pop(context);
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(
                                earnedXp
                                    ? 'História concluída! +30 XP 🌟'
                                    : 'Você releu uma história já concluída. Continue explorando! 🌱',
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(currentPage == pages.length - 1 ? 'Concluir' : 'Próximo trecho'),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _MatchedSignCard extends StatelessWidget {
  const _MatchedSignCard({required this.match});
  final StorySignMatch match;

  @override
  Widget build(BuildContext context) {
    final SignEntry entry = match.entry;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: entry.categoryColor.withOpacity(.14), borderRadius: BorderRadius.circular(12)),
            child: Text(entry.categoryEmoji, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 9),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(entry.term, style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink)),
            Text(
              '${entry.categoryTitle} · ${match.occurrences} ${match.occurrences == 1 ? 'ocorrência' : 'ocorrências'}',
              style: const TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ])),
        ]),
        const SizedBox(height: 9),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFFFFF5D9), borderRadius: BorderRadius.circular(12)),
          child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.pending_actions_rounded, size: 17, color: Color(0xFF946A17)),
            SizedBox(width: 7),
            Expanded(child: Text('Registro do manual aguardando validação linguística. O botão abre o Widget para tradução automática do texto, mas não confirma uma variante ou o uso contextual do sinal.', style: TextStyle(color: AppColors.ink, fontSize: 10, height: 1.35))),
          ]),
        ),
        const SizedBox(height: 8),
        VlibrasDemoButton(entry: entry),
      ]),
    );
  }
}

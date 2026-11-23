import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/story.dart';
import '../../services/story_sign_matcher.dart';
import '../../state/sinalmundo_controller.dart';
import '../../widgets/signs/vlibras_demo_button.dart';
import '../../widgets/signs/vlibras_text_demo_button.dart';
import 'story_reader_screen.dart';

class StoryCreatorScreen extends StatefulWidget {
  const StoryCreatorScreen({super.key});

  @override
  State<StoryCreatorScreen> createState() => _StoryCreatorScreenState();
}

class _StoryCreatorScreenState extends State<StoryCreatorScreen> {
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();
  bool _analyzed = false;
  List<StorySignMatch> _matches = const [];
  List<String> _pages = const [];

  @override
  void dispose() {
    _titleController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  void _analyzeStory() {
    final text = _storyController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escreva sua história antes de continuar.')),
      );
      return;
    }

    setState(() {
      _matches = StorySignMatcher.findInText(text);
      _pages = StorySignMatcher.splitIntoPages(text);
      _analyzed = true;
    });
  }

  void _saveAndRead() {
    if (!_analyzed) {
      _analyzeStory();
      if (!_analyzed) return;
    }

    final title = _titleController.text.trim().isEmpty
        ? 'Minha história'
        : _titleController.text.trim();
    final pages = _pages.isEmpty ? [ _storyController.text.trim() ] : _pages;
    final firstPageRunes = pages.first.runes.toList();
    final summary = firstPageRunes.length > 110
        ? '${String.fromCharCodes(firstPageRunes.take(107))}…'
        : pages.first;
    final story = Story(
      id: 'created-${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      summary: summary,
      emoji: '📖',
      pages: pages,
    );

    SinalMundoScope.of(context).addCustomStory(story);
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => StoryReaderScreen(story: story)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Criador de Histórias')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE8FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('✍️', style: TextStyle(fontSize: 34)),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Invente qualquer história! Escreva com suas próprias palavras. O SinalMundo procura termos do catálogo e prepara cada trecho para você solicitar a tradução no VLibras.',
                          style: TextStyle(
                            color: AppColors.purpleDark,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Nome da história', style: _fieldTitleStyle),
                const SizedBox(height: 7),
                TextField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _inputDecoration('Ex.: A aventura de Milo'),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                const Text('Escreva sua história', style: _fieldTitleStyle),
                const SizedBox(height: 7),
                TextField(
                  controller: _storyController,
                  minLines: 7,
                  maxLines: 14,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  decoration: _inputDecoration(
                    'Era uma vez...\n\nVocê pode escrever sobre pessoas, animais, lugares, sonhos ou qualquer aventura!',
                  ),
                  onChanged: (_) => setState(() => _analyzed = false),
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: _analyzeStory,
                  icon: const Icon(Icons.auto_awesome_rounded),
                  label: const Text('Encontrar sinais na minha história'),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                ),
                if (_analyzed) ...[
                  const SizedBox(height: 22),
                  _buildAnalysis(),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: _saveAndRead,
                    icon: const Icon(Icons.menu_book_rounded),
                    label: const Text('Guardar e começar a ler'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                const Text(
                  'O catálogo local reconhece somente os seus 90 termos. Para outras palavras e frases, o texto pode ser enviado ao tradutor automático, cuja resposta depende do vocabulário e do contexto disponíveis. Nenhum sinal ausente é inventado.',
                  style: TextStyle(color: AppColors.muted, fontSize: 11, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysis() {
    final title = _titleController.text.trim().isEmpty
        ? 'Minha história'
        : _titleController.text.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: AppColors.purpleDark)),
            const SizedBox(height: 8),
            Text(_storyController.text.trim(), style: const TextStyle(fontSize: 15, height: 1.5, color: AppColors.ink)),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.menu_book_rounded, size: 17, color: AppColors.blueDark),
              const SizedBox(width: 6),
              Text('${_pages.length} trecho(s) para ler e enviar ao VLibras', style: const TextStyle(fontSize: 12, color: AppColors.muted, fontWeight: FontWeight.w700)),
            ]),
          ]),
        ),
        const SizedBox(height: 18),
        Row(children: [
          const Expanded(child: Text('Sinais encontrados no catálogo', style: _sectionTitleStyle)),
          Text('${_matches.length}', style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.w900)),
        ]),
        const SizedBox(height: 8),
        if (_matches.isEmpty)
          _notice(
            icon: Icons.info_outline_rounded,
            message: 'Não encontrei correspondências no catálogo de 90 sinais neste texto. Você ainda pode preparar cada trecho para tradução automática no VLibras.',
          )
        else
          ..._matches.map(_buildMatchCard),
        const SizedBox(height: 17),
        const Text('Enviar trechos para tradução', style: _sectionTitleStyle),
        const SizedBox(height: 8),
        const Text(
          'Cada trecho pode ser enviado ao Widget oficial. Na página que abrir, clique no botão flutuante e selecione o texto para solicitar a tradução. Ela não começa automaticamente.',
          style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 9),
        ...List.generate(_pages.length, (index) => _buildPageDemo(index, _pages[index])),
      ],
    );
  }

  Widget _buildMatchCard(StorySignMatch match) {
    final entry = match.entry;
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: entry.categoryColor.withOpacity(.14), borderRadius: BorderRadius.circular(13)),
            child: Text(entry.categoryEmoji, style: const TextStyle(fontSize: 23)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(entry.term, style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink)),
            Text('${entry.categoryTitle} · ${match.occurrences} ocorrência(s)', style: const TextStyle(fontSize: 11, color: AppColors.muted)),
          ])),
          const Icon(Icons.pending_actions_rounded, color: Color(0xFF825D16)),
        ]),
        const SizedBox(height: 8),
        const Text('Termo correspondente no catálogo. Abra o Widget para solicitar a tradução:', style: TextStyle(fontSize: 11, color: AppColors.muted)),
        const SizedBox(height: 5),
        VlibrasDemoButton(entry: entry),
        const SizedBox(height: 7),
        const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.pending_actions_rounded, size: 14, color: Color(0xFF946A17)),
          SizedBox(width: 5),
          Expanded(child: Text('Registro aguardando validação linguística. Confira a tradução automática com um educador fluente em Libras.', style: TextStyle(fontSize: 10, color: AppColors.muted, height: 1.35))),
        ]),
      ]),
    );
  }

  Widget _buildPageDemo(int index, String page) {
    final pageMatches = StorySignMatcher.findInText(page);
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F7FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8E8F8)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Trecho ${index + 1}', style: const TextStyle(color: AppColors.blueDark, fontWeight: FontWeight.w900, fontSize: 12)),
        const SizedBox(height: 5),
        Text(page, style: const TextStyle(color: AppColors.ink, height: 1.4)),
        const SizedBox(height: 8),
        VlibrasTextDemoButton(text: page, label: 'Abrir tradução do trecho'),
        if (pageMatches.isEmpty) ...[
          const SizedBox(height: 6),
          const Text('Sem correspondência direta no catálogo local. O trecho completo pode ser enviado ao tradutor automático.', style: TextStyle(fontSize: 10, color: AppColors.muted)),
        ],
      ]),
    );
  }

  Widget _notice({required IconData icon, required String message}) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: const Color(0xFFFFF5D9), borderRadius: BorderRadius.circular(15)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: const Color(0xFF946A17)),
      const SizedBox(width: 8),
      Expanded(child: Text(message, style: const TextStyle(color: AppColors.ink, fontSize: 12, height: 1.4))),
    ]),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.45),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(15),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.purple, width: 2)),
  );

  static const _fieldTitleStyle = TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink);
  static const _sectionTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.purpleDark);
}

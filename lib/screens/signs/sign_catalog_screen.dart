import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/demo_data.dart';
import '../../data/sign_catalog_data.dart';
import '../../models/sign_entry.dart';
import '../../services/story_sign_matcher.dart';
import '../../widgets/section_title.dart';
import '../../widgets/signs/sign_demo_2d.dart';
import 'sign_detail_screen.dart';

class SignCatalogScreen extends StatefulWidget {
  const SignCatalogScreen({super.key});

  @override
  State<SignCatalogScreen> createState() => _SignCatalogScreenState();
}

class _SignCatalogScreenState extends State<SignCatalogScreen> {
  final TextEditingController _search = TextEditingController();
  String? _categoryId;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<SignEntry> get _filtered {
    final query = StorySignMatcher.normalize(_search.text.trim());
    return SignCatalogData.entries.where((entry) {
      final matchesQuery = query.isEmpty ||
          StorySignMatcher.normalize(entry.term).contains(query);
      final matchesCategory = _categoryId == null || entry.categoryId == _categoryId;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final entries = _filtered;
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
                    title: 'Catálogo de Sinais',
                    subtitle: 'Explore os termos organizados pelos temas do Mundo Vivo.',
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _search,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Buscar um termo, como “família” ou “escola”',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _search.text.isEmpty ? null : IconButton(icon: const Icon(Icons.close), onPressed: () { _search.clear(); setState(() {}); }),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 13),
                  SizedBox(
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: ChoiceChip(label: const Text('Todos'), selected: _categoryId == null, onSelected: (_) => setState(() => _categoryId = null)),
                        ),
                        for (final topic in DemoData.topics)
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: ChoiceChip(
                              label: Text('${topic.emoji} ${topic.title}'),
                              selected: _categoryId == topic.id,
                              onSelected: (_) => setState(() => _categoryId = topic.id),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(color: const Color(0xFFFFF5D9), borderRadius: BorderRadius.circular(16)),
                    child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(Icons.info_outline_rounded, color: Color(0xFF946A17)),
                      SizedBox(width: 9),
                      Expanded(child: Text('O catálogo reúne 90 registros transcritos dos manuais. Abra uma ficha para consultar os cinco parâmetros e acessar o Widget oficial do VLibras. A demonstração específica de cada sinal só será exibida depois de validada.', style: TextStyle(color: AppColors.ink, fontSize: 12, height: 1.4))),
                    ]),
                  ),
                  const SizedBox(height: 18),
                  Text('${entries.length} sinais/termos no catálogo', style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w700, fontSize: 12)),
                  const SizedBox(height: 9),
                  LayoutBuilder(builder: (context, constraints) {
                    final columns = constraints.maxWidth > 1040 ? 4 : constraints.maxWidth > 700 ? 3 : constraints.maxWidth > 420 ? 2 : 1;
                    if (entries.isEmpty) {
                      return Container(width: double.infinity, padding: const EdgeInsets.all(25), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: const Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.search_off_rounded, size: 34, color: AppColors.muted), SizedBox(height: 8), Text('Nenhum termo encontrado.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink)), SizedBox(height: 4), Text('Tente outra palavra ou selecione “Todos”.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted, fontSize: 12))]));
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: entries.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: columns == 1 ? 3.2 : 1.45),
                      itemBuilder: (context, index) => _SignCard(entry: entries[index], onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => SignDetailScreen(entry: entries[index])))),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignCard extends StatelessWidget {
  const _SignCard({required this.entry, required this.onTap});
  final SignEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
          child: Row(children: [
            Container(width: 42, height: 46, alignment: Alignment.center, decoration: BoxDecoration(color: entry.categoryColor.withOpacity(.14), borderRadius: BorderRadius.circular(14)), child: Text(entry.categoryEmoji, style: const TextStyle(fontSize: 24))),
            const SizedBox(width: 5),
            SignDemo2D(entry: entry, compact: true),
            const SizedBox(width: 7),
            Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(entry.term, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink)),
              Text(entry.categoryTitle, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
              const SizedBox(height: 3),
              const Text('Demonstração pendente', style: TextStyle(fontSize: 10, color: Color(0xFF946A17), fontWeight: FontWeight.w700)),
            ])),
            const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
          ]),
        ),
      ),
    );
  }
}

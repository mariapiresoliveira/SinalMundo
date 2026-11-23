import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/sign_entry.dart';
import '../../state/sinalmundo_controller.dart';
import '../../widgets/section_title.dart';
import '../../widgets/signs/sign_demo_2d.dart';
import '../../widgets/signs/vlibras_demo_button.dart';

class SignDetailScreen extends StatelessWidget {
  const SignDetailScreen({super.key, required this.entry});

  final SignEntry entry;

  @override
  Widget build(BuildContext context) {
    final controller = SinalMundoScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(entry.term)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: entry.categoryColor.withOpacity(.14),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(entry.categoryEmoji, style: const TextStyle(fontSize: 32)),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.term, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: AppColors.ink)),
                            Text(entry.categoryTitle, style: TextStyle(color: entry.categoryColor, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      _StatusChip(status: entry.reviewStatus),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const SectionTitle(
                    title: 'Tradução com o VLibras 3D',
                    subtitle: 'Prepare o termo no Widget oficial. A tradução começa quando você selecionar o texto na página aberta.',
                  ),
                  const SizedBox(height: 10),
                  VlibrasDemoButton(entry: entry),
                  const SizedBox(height: 9),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF4FF),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFB8D7F5)),
                    ),
                    child: SelectableText(
                      'Texto preparado para tradução: ${entry.term}',
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A tradução não começa automaticamente. Na página que abrir, clique no botão flutuante do VLibras e selecione o termo destacado para solicitar a tradução com o avatar 3D.',
                    style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 18),
                  const SectionTitle(
                    title: 'Referência visual do sinal',
                    subtitle: 'A demonstração específica deste termo ainda está pendente de validação.',
                  ),
                  const SizedBox(height: 10),
                  SignDemo2D(entry: entry),
                  const SizedBox(height: 22),
                  const SectionTitle(title: 'Cinco parâmetros do sinal', subtitle: 'Transcrição do catálogo enviado; ainda pendente de validação linguística.'),
                  const SizedBox(height: 10),
                  _DescriptionField(title: 'Contexto / observação', value: entry.contextText),
                  _DescriptionField(title: 'Configuração da mão (CM)', value: '${entry.handConfiguration}\n\n${entry.handShapeDescription}'),
                  _DescriptionField(title: 'Posição da mão no corpo/espaço (PA)', value: '${entry.location}\n\n${entry.handPositionDescription}'),
                  _DescriptionField(title: 'Movimento (M)', value: '${entry.movement}\n\n${entry.movementNote}'),
                  _DescriptionField(title: 'Orientação da palma', value: entry.palmOrientation),
                  _DescriptionField(title: 'Expressões não manuais', value: entry.nonManualMarkers),
                  _DescriptionField(title: 'Variações regionais', value: entry.regionalVariation),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                    child: ExpansionTile(
                      title: const Text('Ver diagramas gerais dos parâmetros', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.purpleDark, fontSize: 13)),
                      subtitle: const Text('Referências ilustradas dos PDFs enviados', style: TextStyle(fontSize: 11, color: AppColors.muted)),
                      childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                      children: const [
                        _ReferenceDiagram(title: 'Configurações de mão (CM)', asset: 'assets/reference/configuracoes_mao_cm.png'),
                        _ReferenceDiagram(title: 'Pontos de articulação (PA)', asset: 'assets/reference/pontos_articulacao_pa.png'),
                        _ReferenceDiagram(title: 'Movimento (M) e orientação (O)', asset: 'assets/reference/movimento_orientacao.png'),
                        _ReferenceDiagram(title: 'Expressões não manuais (ENM)', asset: 'assets/reference/expressoes_nao_manuais.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: const Color(0xFFFFF5D9), borderRadius: BorderRadius.circular(17)),
                    child: Text('${entry.reviewNote} Fonte: Guia Completo de Libras, página ${entry.sourcePage}.', style: const TextStyle(color: AppColors.ink, fontSize: 12, height: 1.4)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: controller.hasViewedSign(entry.id)
                          ? null
                          : () {
                              controller.markSignViewed(entry.id);
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(const SnackBar(content: Text('Termo registrado na sua jornada. +5 XP')));
                            },
                      icon: Icon(
                        controller.hasViewedSign(entry.id)
                            ? Icons.check_circle_rounded
                            : Icons.bookmark_added_rounded,
                      ),
                      label: Text(
                        controller.hasViewedSign(entry.id)
                            ? 'Termo já registrado na jornada'
                            : 'Registrar como visto · +5 XP',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'O VLibras realiza tradução automática do texto selecionado e pode apresentar outra formulação, variante regional ou não encontrar correspondência. A tradução automática não substitui a validação do sinal específico por pessoas fluentes em Libras e educadores bilíngues.',
                    style: TextStyle(color: AppColors.muted, fontSize: 11, height: 1.35),
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final SignReviewStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      SignReviewStatus.pending => const Color(0xFF9A6B12),
      SignReviewStatus.inReview => AppColors.blueDark,
      SignReviewStatus.approved => AppColors.green,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: color.withOpacity(.11), borderRadius: BorderRadius.circular(20)),
      child: Text(status.label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({required this.title, required this.value});
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: AppColors.purpleDark, fontWeight: FontWeight.w900, fontSize: 13)),
        const SizedBox(height: 4),
        Text(value?.trim().isNotEmpty == true ? value! : 'Descrição será preenchida após revisão linguística.', style: const TextStyle(color: AppColors.muted, fontSize: 12, height: 1.35)),
      ]),
    );
  }
}


class _ReferenceDiagram extends StatelessWidget {
  const _ReferenceDiagram({required this.title, required this.asset});
  final String title;
  final String asset;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink, fontSize: 12)),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: const Color(0xFFF8F9FC),
          width: double.infinity,
          padding: const EdgeInsets.all(6),
          child: Image.asset(asset, width: double.infinity, height: 220, fit: BoxFit.contain),
        ),
      ),
    ]),
  );
}

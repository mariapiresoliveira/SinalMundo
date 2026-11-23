import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../widgets/section_title.dart';

class EducatorScreen extends StatelessWidget {
  const EducatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_EducatorInfo>[
      const _EducatorInfo(
        title: 'Turmas',
        description: 'Organize grupos e acompanhe a jornada de aprendizagem.',
        icon: Icons.groups_rounded,
        detail: 'Exemplo fictício · 1 turma · 18 alunos',
      ),
      const _EducatorInfo(
        title: 'Catálogo de sinais',
        description: 'Consulte termos e fichas que aguardam revisão linguística.',
        icon: Icons.waving_hand_rounded,
        detail: '90 registros · aguardando validação',
      ),
      const _EducatorInfo(
        title: 'Relatórios',
        description: 'Visualize sinais vistos, histórias lidas e temas explorados.',
        icon: Icons.analytics_rounded,
        detail: 'Relatório demonstrativo',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1050),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    title: 'Área do Educador',
                    subtitle: 'Uma visão de apoio para acompanhar a aprendizagem.',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(19),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.lavender, AppColors.paleBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Row(
                      children: [
                        Text('👩‍🏫', style: TextStyle(fontSize: 41)),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Olá, educador(a)!',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.purpleDark,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Acompanhe os temas explorados e confira o estado de revisão dos registros de Libras.',
                                style: TextStyle(color: AppColors.ink, height: 1.4, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth > 760 ? 3 : 1;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 13,
                          childAspectRatio: columns == 1
                              ? (constraints.maxWidth < 480 ? 1.4 : 3.2)
                              : 1.48,
                        ),
                        itemBuilder: (context, index) => _EducatorCard(info: items[index]),
                      );
                    },
                  ),
                  const SizedBox(height: 13),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline_rounded, color: AppColors.muted, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Esta é uma prévia local. Cadastro de educadores, turmas reais e relatórios sincronizados dependem de uma integração futura com Firebase ou outro serviço de dados.',
                            style: TextStyle(color: AppColors.muted, fontSize: 11, height: 1.4),
                          ),
                        ),
                      ],
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
}

class _EducatorInfo {
  const _EducatorInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.detail,
  });

  final String title;
  final String description;
  final IconData icon;
  final String detail;
}

class _EducatorCard extends StatelessWidget {
  const _EducatorCard({required this.info});

  final _EducatorInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.lavender,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(info.icon, size: 25, color: AppColors.purple),
          ),
          const SizedBox(height: 11),
          Text(
            info.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.ink),
          ),
          const SizedBox(height: 5),
          Text(
            info.description,
            style: const TextStyle(fontSize: 12, color: AppColors.muted, height: 1.35),
          ),
          const SizedBox(height: 10),
          Text(
            info.detail,
            style: const TextStyle(fontSize: 11, color: AppColors.blueDark, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

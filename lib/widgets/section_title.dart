import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.subtitle, this.trailing});

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.ink)),
            if (subtitle != null) ...[
              const SizedBox(height: 3),
              Text(subtitle!, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
            ],
          ]),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

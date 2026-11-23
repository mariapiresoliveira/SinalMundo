import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class ModuleCard extends StatelessWidget {
  const ModuleCard({super.key, required this.title, required this.description, required this.emoji, required this.color, required this.onTap, this.badge});

  final String title;
  final String description;
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.purpleDark.withOpacity(.06),
      borderRadius: BorderRadius.circular(23),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(23),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 54, height: 54, alignment: Alignment.center, decoration: BoxDecoration(color: color.withOpacity(.13), borderRadius: BorderRadius.circular(17)), child: Text(emoji, style: const TextStyle(fontSize: 29))),
              const Spacer(),
              if (badge != null) Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: color.withOpacity(.12), borderRadius: BorderRadius.circular(20)), child: Text(badge!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: color))),
              const Icon(Icons.arrow_outward_rounded, color: AppColors.muted, size: 19),
            ]),
            const Spacer(),
            Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.ink)),
            const SizedBox(height: 5),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, height: 1.35, color: AppColors.muted),
            ),
          ]),
        ),
      ),
    );
  }
}

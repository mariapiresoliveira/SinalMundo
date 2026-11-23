import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class MiloAvatar extends StatelessWidget {
  const MiloAvatar({super.key, this.size = 64, this.showLeaf = true});

  final double size;
  final bool showLeaf;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Milo, guia do SinalMundo',
      image: true,
      child: ExcludeSemantics(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE5F5FF),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x223A3970),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text('🧒', style: TextStyle(fontSize: size * .57)),
            ),
            if (showLeaf)
              Positioned(
                right: -2,
                top: -4,
                child: Transform.rotate(
                  angle: -.45,
                  child: Icon(
                    Icons.eco_rounded,
                    color: AppColors.green,
                    size: size * .28,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

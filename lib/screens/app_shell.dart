import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../widgets/milo_avatar.dart';
import 'educator/educator_screen.dart';
import 'home/home_screen.dart';
import 'signs/sign_catalog_screen.dart';
import 'stories/stories_screen.dart';
import 'tree/tree_screen.dart';
import 'world/world_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  static const destinations = <_Destination>[
    _Destination('Início', Icons.home_rounded),
    _Destination('Mundo Vivo', Icons.explore_rounded),
    _Destination('Sinais', Icons.waving_hand_rounded),
    _Destination('Histórias', Icons.auto_stories_rounded),
    _Destination('Árvore', Icons.park_rounded),
    _Destination('Educador', Icons.school_rounded),
  ];

  final pages = const <Widget>[
    HomeScreen(),
    WorldScreen(),
    SignCatalogScreen(),
    StoriesScreen(),
    TreeScreen(),
    EducatorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 950;
      return Scaffold(
        body: Row(children: [
          if (wide) _sideNavigation(),
          Expanded(child: IndexedStack(index: selectedIndex, children: pages)),
        ]),
        bottomNavigationBar: wide ? null : NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) => setState(() => selectedIndex = index),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: destinations
              .map((d) => NavigationDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.icon, color: AppColors.purpleDark),
                    label: d.label,
                  ))
              .toList(),
        ),
      );
    });
  }

  Widget _sideNavigation() {
    return Container(
      width: 230,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 20, 14, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 43,
                        height: 43,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.waving_hand_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'SinalMundo',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: AppColors.purpleDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  const Center(child: MiloAvatar(size: 74)),
                  const SizedBox(height: 9),
                  const Center(
                    child: Text(
                      'Olá, explorador!',
                      style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                  ),
                  const SizedBox(height: 24),
                  for (var i = 0; i < destinations.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: _navItem(i),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.yellow.withOpacity(.22),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '🌱 Cada sinal é uma nova descoberta!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.purpleDark,
                height: 1.3,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(int index) {
    final item = destinations[index];
    final selected = index == selectedIndex;
    return Material(
      color: selected ? AppColors.purple.withOpacity(.10) : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => setState(() => selectedIndex = index),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(children: [
            Icon(item.icon, color: selected ? AppColors.purple : AppColors.muted),
            const SizedBox(width: 12),
            Text(item.label, style: TextStyle(fontWeight: selected ? FontWeight.w900 : FontWeight.w600, color: selected ? AppColors.purpleDark : AppColors.muted)),
          ]),
        ),
      ),
    );
  }
}

class _Destination {
  const _Destination(this.label, this.icon);
  final String label;
  final IconData icon;
}

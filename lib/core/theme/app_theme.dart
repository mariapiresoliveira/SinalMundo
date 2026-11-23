import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      brightness: Brightness.light,
      primary: AppColors.purple,
      onPrimary: Colors.white,
      secondary: AppColors.green,
      onSecondary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      error: const Color(0xFFB54A4A),
    );

    final rounded = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      visualDensity: VisualDensity.standard,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 19,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.purple, width: 1.8),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: Colors.white,
          shape: rounded,
          minimumSize: const Size(44, 48),
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.purpleDark,
          side: const BorderSide(color: AppColors.purple),
          shape: rounded,
          minimumSize: const Size(44, 46),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.lavender,
        side: const BorderSide(color: AppColors.border),
        shape: const StadiumBorder(),
        labelStyle: const TextStyle(color: AppColors.ink, fontSize: 12),
        secondaryLabelStyle: const TextStyle(color: AppColors.purpleDark, fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.lavender,
        height: 70,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            color: selected ? AppColors.purpleDark : AppColors.muted,
            fontSize: 10,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          );
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.purpleDark,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: AppColors.muted),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.purple,
        selectionColor: Color(0x337B68D9),
        selectionHandleColor: AppColors.purple,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.green,
        linearTrackColor: AppColors.mint,
        circularTrackColor: AppColors.mint,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        modalBackgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
    );
  }
}

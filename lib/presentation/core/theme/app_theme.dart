import 'package:flutter/material.dart';

/// Brand palette, taken from refreshi.co.za's design tokens.
abstract final class RefreshiColors {
  static const forest = Color(0xFF1E3024);
  static const ink = Color(0xFF1D2B24);
  static const cream = Color(0xFFF6F3EE);
  static const creamLight = Color(0xFFF7F2ED);
  static const paper = Color(0xFFFFFDF9);
  static const lime = Color(0xFFE9F44D);
  static const orange = Color(0xFFFF7517);

  /// Brand orange darkened for text and icons on light surfaces: bright
  /// orange is only 2.4:1 on cream, this is 4.7:1 (WCAG AA). Bright orange
  /// stays for fills and for text on forest (5.2:1).
  static const orangeInk = Color(0xFFB84A05);
  static const sage = Color(0xFFBBCDCF);
  static const border = Color(0xFFC7D1CC);
  static const muted = Color(0xFF5C7066);
  static const forestRaised = Color(0xFF2A3F31);
}

/// Font families. They fall back to the platform font until the font files
/// are bundled under assets/fonts and declared in pubspec.yaml.
abstract final class RefreshiFonts {
  static const body = 'DM Sans';
  static const display = 'Clash Display';
  static const _fallback = ['DM Sans', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif'];
  static const fallback = _fallback;
}

abstract final class AppTheme {
  static ThemeData light() => _build(
    const ColorScheme(
      brightness: Brightness.light,
      primary: RefreshiColors.forest,
      onPrimary: RefreshiColors.lime,
      primaryContainer: RefreshiColors.lime,
      onPrimaryContainer: RefreshiColors.forest,
      secondary: RefreshiColors.orange,
      onSecondary: RefreshiColors.forest,
      secondaryContainer: Color(0xFFFFE2CF),
      onSecondaryContainer: RefreshiColors.forest,
      tertiary: RefreshiColors.sage,
      onTertiary: RefreshiColors.forest,
      tertiaryContainer: Color(0xFFF4F8C4),
      onTertiaryContainer: RefreshiColors.forest,
      error: Color(0xFFD5560F),
      onError: Colors.white,
      errorContainer: Color(0xFFFFE2CF),
      onErrorContainer: Color(0xFF7A2A00),
      surface: RefreshiColors.paper,
      onSurface: RefreshiColors.ink,
      onSurfaceVariant: RefreshiColors.muted,
      surfaceContainerLowest: RefreshiColors.cream,
      surfaceContainerLow: RefreshiColors.creamLight,
      surfaceContainer: Color(0xFFEFEBE4),
      surfaceContainerHigh: Color(0xFFE8E4DC),
      surfaceContainerHighest: Color(0xFFE1DDD4),
      outline: Color(0xFF8A9A92),
      outlineVariant: RefreshiColors.border,
      inverseSurface: RefreshiColors.forest,
      onInverseSurface: RefreshiColors.creamLight,
      inversePrimary: RefreshiColors.lime,
    ),
  );

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(colorScheme: scheme, useMaterial3: true, fontFamily: RefreshiFonts.body);
    const display = TextStyle(
      fontFamily: RefreshiFonts.display,
      fontFamilyFallback: RefreshiFonts.fallback,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.05,
    );
    final text = base.textTheme
        .copyWith(
          displayLarge: base.textTheme.displayLarge?.merge(display),
          displayMedium: base.textTheme.displayMedium?.merge(display),
          displaySmall: base.textTheme.displaySmall?.merge(display),
          headlineLarge: base.textTheme.headlineLarge?.merge(display),
          headlineMedium: base.textTheme.headlineMedium?.merge(display),
          headlineSmall: base.textTheme.headlineSmall?.merge(display),
          titleLarge: base.textTheme.titleLarge?.merge(display.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0)),
          titleMedium: base.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          labelLarge: base.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    const pill = StadiumBorder();
    const buttonText = TextStyle(fontFamily: RefreshiFonts.body, fontWeight: FontWeight.w700, fontSize: 15);

    // A strong, consistent keyboard focus ring (WCAG 2.4.7 focus visible).
    final focusRing = WidgetStateProperty.resolveWith<BorderSide?>(
      (states) =>
          states.contains(WidgetState.focused) ? const BorderSide(color: RefreshiColors.orangeInk, width: 3) : null,
    );

    return base.copyWith(
      textTheme: text,
      focusColor: RefreshiColors.lime.withValues(alpha: 0.45),
      scaffoldBackgroundColor: scheme.surfaceContainerLowest,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 28),
          shape: pill,
          textStyle: buttonText,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
        ).copyWith(side: focusRing),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: pill,
              textStyle: buttonText.copyWith(fontSize: 14),
              foregroundColor: scheme.onSurface,
            ).copyWith(
              side: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.focused)
                    ? const BorderSide(color: RefreshiColors.orangeInk, width: 3)
                    : BorderSide(color: scheme.onSurface.withValues(alpha: 0.35), width: 1.5),
              ),
            ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: pill,
          textStyle: buttonText.copyWith(fontSize: 14),
          foregroundColor: scheme.onSurface,
        ).copyWith(side: focusRing),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide(color: scheme.outlineVariant),
        backgroundColor: scheme.surface,
        selectedColor: scheme.primary,
        checkmarkColor: scheme.onPrimary,
        labelStyle: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface),
        secondaryLabelStyle: TextStyle(fontWeight: FontWeight.w600, color: scheme.onPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: scheme.onSurface,
        selectedTileColor: scheme.primaryContainer.withValues(alpha: 0.35),
        iconColor: scheme.onSurfaceVariant,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: RefreshiColors.forest,
        contentTextStyle: const TextStyle(color: RefreshiColors.creamLight, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: scheme.secondaryContainer,
        contentTextStyle: TextStyle(color: scheme.onSecondaryContainer, fontWeight: FontWeight.w500),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:katadia_app/core/constants/design_tokens.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';


class AppTheme {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;
  static const Color error = AppColors.error;
  static Color get success => AppColors.success;
  static const Color warning = AppColors.warning;
  static Color get surface => Colors.white;
  static Color get onSurface => AppColors.textPrimary;
  static Color get onSurfaceVariant => AppColors.textSecondary.withAlpha(13);

  /// Light theme configuration
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: _getTextTheme(false),
    cardTheme: _getCardTheme(false),
    elevatedButtonTheme: _getElevatedButtonTheme(false),
    checkboxTheme: _getCheckboxTheme(false),
    radioTheme: _getRadioTheme(false),
    chipTheme: _getChipTheme(false),
    dataTableTheme: _getDataTableTheme(false),
    listTileTheme: _getListTileTheme(false),
    bottomNavigationBarTheme: _getBottomNavTheme(false),
    floatingActionButtonTheme: _getFabTheme(false),
  );

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: _getTextTheme(true),
    cardTheme: _getCardTheme(true),
    elevatedButtonTheme: _getElevatedButtonTheme(true),
    checkboxTheme: _getCheckboxTheme(true),
    radioTheme: _getRadioTheme(true),
    chipTheme: _getChipTheme(true),
    dataTableTheme: _getDataTableTheme(true),
    listTileTheme: _getListTileTheme(true),
    bottomNavigationBarTheme: _getBottomNavTheme(true),
    floatingActionButtonTheme: _getFabTheme(true),
  );

  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.purple,
    onPrimary: Colors.white,
    secondary: Colors.purple,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    onSurfaceVariant: Colors.grey,
  );

  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.purple,
    onPrimary: Colors.black,
    secondary: Colors.purple,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.grey,
    onSurface: Colors.white,
    onSurfaceVariant: Colors.grey,
  );

  static TextTheme _getTextTheme(bool isDark) {
    final textColor = isDark ? Colors.white60 : Colors.black87;
    
    return TextTheme(
      displaySmall: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSize3xl,
        fontWeight: DesignTokens.fontWeightBold,
      ),
      displayLarge: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSize4xl,
        fontWeight: DesignTokens.fontWeightBold,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSize2xl,
        fontWeight: DesignTokens.fontWeightSemiBold,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSizeXs,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSizeSm,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSizeBase,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSizeLg,
        fontWeight: DesignTokens.fontWeightMedium,
      ),
      labelLarge: TextStyle(
        color: textColor,
        fontSize: DesignTokens.fontSizeBase,
        fontWeight: DesignTokens.fontWeightMedium,
      ),
    );
  }

  static CardThemeData _getCardTheme(bool isDark) {
    return CardThemeData(
      color: isDark
          ? Colors.grey.shade700
          : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
    );
  }

  static ElevatedButtonThemeData _getElevatedButtonTheme(bool isDark) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark
              ? Colors.grey.shade600
              : Colors.purple.shade300,
        elevation: isDark ? 4 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          side: BorderSide(
            color: isDark
              ? Colors.grey.shade600
              : Colors.purple.shade100,
          ),
        ),
      ),
    );
  }

  static CheckboxThemeData _getCheckboxTheme(bool isDark) {
    return CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        isDark
            ? Colors.grey.shade300
            : AppColors.primary,
      ),
      checkColor: MaterialStateProperty.all(
        isDark
            ? Colors.grey.shade300
            : AppColors.primary,
      ),
    );
  }

  static RadioThemeData _getRadioTheme(bool isDark) {
    return RadioThemeData(
      fillColor: MaterialStateProperty.all(
        isDark
            ? Colors.grey.shade300
            : AppColors.primary.withAlpha(3),
      ),
    );
  }

  static ChipThemeData _getChipTheme(bool isDark) {
    return ChipThemeData(
      backgroundColor: isDark
          ? Colors.grey.shade700
          : AppColors.primary.withAlpha(3),
      labelStyle: TextStyle(
        color: isDark
              ? Colors.white
              : AppColors.textPrimary,
      ),
      side: BorderSide(
        color: isDark
              ? Colors.grey.shade500
              : AppColors.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
    );
  }

  static DataTableThemeData _getDataTableTheme(bool isDark) {
    // Tentukan warna-warnanya dulu agar mudah dibaca
    final Color defaultRowColor = isDark ? Colors.grey.shade300 : Colors.white;
    final Color focusRowColor = isDark ? Colors.purple.shade100 : Colors.purple.shade500;
    final Color hoverRowColor = isDark ? Colors.purple.shade200 : Colors.purple.shade600;

    return DataTableThemeData(
      // Gunakan .resolveWith untuk menangani semua status
      dataRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return focusRowColor; // Kembalikan warna fokus
        }
        if (states.contains(MaterialState.hovered)) {
          return hoverRowColor; // Kembalikan warna hover
        }
        // Jika tidak di-hover atau di-fokus, kembalikan warna default
        return defaultRowColor;
      }),
      
      // Bagian headingRowColor Anda sudah benar
      headingRowColor: MaterialStateProperty.all(
        isDark
            ? Colors.grey.shade100
            : Colors.black26,
      ),
    );
  }
  
  static ListTileThemeData _getListTileTheme(bool isDark) {
    return ListTileThemeData(
      textColor: isDark ? Colors.white : Colors.black,
      iconColor: isDark ? Colors.white70 : Colors.black87,
    );
  }

  static BottomNavigationBarThemeData _getBottomNavTheme(bool isDark) {
    // Tentukan warna-warnanya dulu agar mudah dibaca
    final Color selectedIconColor = isDark ? Colors.purple.shade200 : Colors.purple.shade600;
    final Color unselectedIconColor = isDark ? Colors.grey.shade400 : AppColors.textSecondary;
    final Color selectedLabelColor = isDark ? Colors.purple.shade200 : AppColors.textSecondary;
    final Color unselectedLabelColor = isDark ? Colors.grey.shade400 : AppColors.textSecondary;

    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: isDark ? 8.0 : 4.0,

      // --- Perbaikan untuk Ikon ---
      selectedIconTheme: IconThemeData(
        color: selectedIconColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: unselectedIconColor,
      ),

      // --- Perbaikan untuk Label ---
      selectedLabelStyle: TextStyle(
        color: selectedLabelColor,
      ),
      unselectedLabelStyle: TextStyle(
        color: unselectedLabelColor,
      ),
    );
  }

  static FloatingActionButtonThemeData _getFabTheme(bool isDark) {
    return FloatingActionButtonThemeData(
      backgroundColor: isDark
          ? Colors.purple.shade600
          : AppColors.primary,
      elevation: isDark ? 6.0 : 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
    );
  }

  static List<BoxShadow> getCardShadow(bool isDark) {
      return isDark
          ? [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withAlpha(38),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
          : [
            BoxShadow(
              color: Colors.black.withAlpha(128),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ];
  }
  
  static BoxDecoration getCardDecoration({
    Color color = Colors.white,
    Border? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      border: border,
      borderRadius: borderRadius ?? BorderRadius.circular(DesignTokens.radiusMd),
      boxShadow: boxShadow ?? getCardShadow(false),
    );
  }

  static List<BoxShadow> getFloatingActionButtonShadow(bool isDark) {
    return [
        BoxShadow(
          color: Colors.black.withAlpha(64),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
    ];
  }
}

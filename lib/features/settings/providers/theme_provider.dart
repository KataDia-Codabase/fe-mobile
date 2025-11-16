import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeString = prefs.getString('theme_mode') ?? 'system';
      
      final theme = ThemeMode.values.firstWhere(
        (e) => e.toString().split('.').last == themeString,
        orElse: () => ThemeMode.system,
      );
      state = theme;
    } catch (e) {
      state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeString = themeMode.toString().split('.').last;
      await prefs.setString('theme_mode', themeString);
      state = themeMode;
    } catch (e) {
      print('Error setting theme: $e');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppLocale {
  indonesian('id', 'ID', 'Bahasa Indonesia'),
  english('en', 'US', 'English');

  const AppLocale(this.languageCode, this.countryCode, this.displayName);
  
  final String languageCode;
  final String countryCode;
  final String displayName;

  Locale get locale => Locale(languageCode, countryCode);
}

class LanguageSelector extends ConsumerStatefulWidget {
  const LanguageSelector({super.key});

  @override
  ConsumerState<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends ConsumerState<LanguageSelector> {
  AppLocale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    // Get current locale from system or stored preference
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocale();
    });
  }

  void _initializeLocale() {
    final contextLocale = Localizations.localeOf(context);
    _selectedLocale = AppLocale.values.firstWhere(
      (locale) => locale.locale.languageCode == contextLocale.languageCode,
      orElse: () => AppLocale.english,
    );
    setState(() {});
  }

  void _onLanguageChanged(AppLocale? locale) {
    if (locale != null && locale != _selectedLocale) {
      setState(() {
        _selectedLocale = locale;
      });
      // TODO: Implement locale change in app state
      _showLanguageChangedMessage(locale);
    }
  }

  void _showLanguageChangedMessage(AppLocale locale) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed to ${locale.displayName}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<AppLocale>(
          value: _selectedLocale,
          hint: Text(
            'Select Language',
            style: TextStyle(fontSize: 14.sp),
          ),
          isExpanded: true,
          items: AppLocale.values.map((locale) {
            return DropdownMenuItem<AppLocale>(
              value: locale,
              child: Row(
                children: [
                  // Language flag emoji
                  Text(
                    _getLanguageFlag(locale),
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      locale.displayName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_selectedLocale == locale)
                    Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                      size: 20.w,
                    ),
                ],
              ),
            );
          }).toList(),
          onChanged: _onLanguageChanged,
        ),
      ),
    );
  }

  String _getLanguageFlag(AppLocale locale) {
    switch (locale) {
      case AppLocale.indonesian:
        return '🇮🇩';
      case AppLocale.english:
        return '🇺🇸';
    }
  }
}

/// Simple language selector widget for settings
class SimpleLanguageSelector extends ConsumerWidget {
  const SimpleLanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.language,
            color: Theme.of(context).primaryColor,
            size: 24.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Choose your preferred language',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const LanguageSelector(),
        ],
      ),
    );
  }
}

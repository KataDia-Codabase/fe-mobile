/// Utility class for string formatting and manipulation
class StringFormatter {
  /// Capitalize first letter of string
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  /// Capitalize first letter of each word
  static String capitalizeWords(String value) {
    return value.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Format number with thousand separator (e.g., 1000 -> "1,000")
  static String formatNumber(num value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)},',
        );
  }

  /// Format currency (e.g., 1000 -> "Rp 1,000")
  static String formatCurrency(num value, {String currency = 'Rp'}) {
    return '$currency ${formatNumber(value)}';
  }

  /// Truncate string to specific length with ellipsis
  static String truncate(String value, int length, {String ellipsis = '...'}) {
    if (value.length <= length) return value;
    return '${value.substring(0, length)}$ellipsis';
  }

  /// Remove extra whitespace
  static String removeExtraSpaces(String value) {
    return value.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Check if string contains only letters
  static bool isAlphabetic(String value) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }

  /// Check if string contains only alphanumeric characters
  static bool isAlphaNumeric(String value) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
  }

  /// Check if string contains only numbers
  static bool isNumeric(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  /// Reverse string
  static String reverse(String value) {
    return value.split('').reversed.join('');
  }

  /// Repeat string n times
  static String repeat(String value, int times) {
    return value * times;
  }

  /// Format phone number (e.g., "081234567890" -> "0812 3456 7890")
  static String formatPhoneNumber(String value) {
    final clean = value.replaceAll(RegExp(r'[^\d]'), '');
    if (clean.length < 10) return clean;

    return '${clean.substring(0, 4)} ${clean.substring(4, 8)} ${clean.substring(8)}';
  }

  /// Convert snake_case to camelCase
  static String snakeToCamelCase(String value) {
    final parts = value.split('_');
    return parts.first + parts.skip(1).map((p) => capitalize(p)).join();
  }

  /// Convert camelCase to snake_case
  static String camelCaseToSnakeCase(String value) {
    return value
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => '_${match.group(0)?.toLowerCase()}',
        )
        .toLowerCase();
  }

  /// Remove trailing/leading special characters
  static String removeSpecialCharacters(String value) {
    return value.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  /// Highlight search term in string (returns plain string for display)
  static String highlightSearchTerm(String text, String searchTerm) {
    if (searchTerm.isEmpty) return text;

    // For display purposes, just return the text
    // In UI, use package like text_highlight to show actual highlighting
    return text;
  }

  /// Get initials from name (e.g., "John Doe" -> "JD")
  static String getInitials(String name) {
    final words = name.trim().split(' ');
    return words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : '').join();
  }

  /// Format XP number with proper formatting
  static String formatXP(int xp) {
    if (xp >= 1000000) {
      return '${(xp / 1000000).toStringAsFixed(1)}M XP';
    } else if (xp >= 1000) {
      return '${(xp / 1000).toStringAsFixed(1)}K XP';
    } else {
      return '$xp XP';
    }
  }
}

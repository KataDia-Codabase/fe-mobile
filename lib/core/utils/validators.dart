/// Utility class for form validation
class Validators {
  /// Validate if email is valid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    // Simple email regex
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  /// Validate if password meets requirements
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi tidak boleh kosong';
    }

    if (value.length < 8) {
      return 'Kata sandi minimal 8 karakter';
    }

    // Check for uppercase
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Kata sandi harus mengandung huruf besar';
    }

    // Check for lowercase
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Kata sandi harus mengandung huruf kecil';
    }

    // Check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Kata sandi harus mengandung angka';
    }

    return null;
  }

  /// Validate if name is valid (not empty, reasonable length)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }

    if (value.length < 2) {
      return 'Nama minimal 2 karakter';
    }

    if (value.length > 50) {
      return 'Nama maksimal 50 karakter';
    }

    return null;
  }

  /// Validate if field is not empty
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? "Field"} tidak boleh kosong';
    }
    return null;
  }

  /// Validate if value matches pattern
  static String? validatePattern(String? value, String pattern,
      {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong';
    }

    if (!RegExp(pattern).hasMatch(value)) {
      return errorMessage ?? 'Format tidak valid';
    }

    return null;
  }

  /// Validate password confirmation
  static String? validatePasswordMatch(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi kata sandi tidak boleh kosong';
    }

    if (value != originalPassword) {
      return 'Kata sandi tidak cocok';
    }

    return null;
  }
}

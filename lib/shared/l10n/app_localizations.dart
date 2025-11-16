import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to get the current localizations
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Labels and common text
  String get appName => 'KataDia';
  String get welcome => 'Welcome to KataDia';
  String get tagline => 'Learn Indonesian & English with AI-powered pronunciation feedback';
  String get signIn => 'Sign In';
  String get signUp => 'Sign Up';
  String get createAccount => 'Create Account';
  String get alreadyHaveAccount => 'Already have an account?';
  String get dontHaveAccount => 'Don\'t have an account?';

  // Auth fields
  String get fullName => 'Full Name';
  String get email => 'Email';
  String get password => 'Password';
  String get confirmPassword => 'Confirm Password';
  String get forgotPassword => 'Forgot Password?';
  String get rememberMe => 'Remember me';

  // Auth field hints
  String get enterFullName => 'Enter your full name';
  String get enterEmail => 'Enter your email';
  String get createPassword => 'Create a password';
  String get enterPassword => 'Enter your password';

  // Buttons
  String get createAccountButton => 'Create Account';
  String get continueWithGoogle => 'Continue with Google';
  String get continueWithApple => 'Continue with Apple';
  String get signUpWithGoogle => 'Sign up with Google';
  String get signUpWithApple => 'Sign up with Apple';

  // Divider text
  String get orContinueWith => 'Or continue with';
  String get orSignUpWith => 'Or sign up with';

  // Terms and Privacy
  String get agreeToTerms => 'I agree to the ';
  String get termsAndConditions => 'Terms and Conditions';
  String get and => ' and ';
  String get privacyPolicy => 'Privacy Policy';

  // Validation errors
  String get requiredField => 'Please enter your';
  String get validEmail => 'Please enter a valid email';
  String get nameTooShort => 'Name must be at least 2 characters';
  String get passwordTooShort => 'Password must be at least 8 characters';
  String get passwordsDoNotMatch => 'Passwords do not match';

  // Loading
  String get loading => 'Loading...';
  String get authenticating => 'Authenticating...';
  String get creatingAccount => 'Creating account...';

  // Error messages
  String get authenticationFailed => 'Authentication failed';
  String get invalidCredentials => 'Invalid email or password';
  String get networkError => 'Network error occurred';
  String get unknownError => 'An unknown error occurred';

  // Navigation
  String get back => 'Back';
  String get cancel => 'Cancel';
  String get done => 'Done';
  String get skip => 'Skip';
  String get next => 'Next';
  String get retry => 'Retry';

  // Success messages
  String get loginSuccessful => 'Login successful';
  String get registrationSuccessful => 'Account created successfully';

  // Common
  String get okay => 'Okay';
  String get dismiss => 'Dismiss';

  // Language
  String get changeLanguage => 'Change Language';
  String get english => 'English';
  String get indonesian => 'Bahasa Indonesia';

  // Get localized string based on current locale
  String _getString(String key, Map<String, String> englishMap, Map<String, String> indonesianMap) {
    if (locale.languageCode == 'id') {
      return indonesianMap[key] ?? englishMap[key] ?? key;
    }
    return englishMap[key] ?? key;
  }

  // For future dynamic localization
  Map<String, String> get englishStrings => {
    'app_name': appName,
    'welcome': welcome,
    'tagline': tagline,
    'sign_in': signIn,
    'sign_up': signUp,
    'create_account': createAccount,
    'already_have_account': alreadyHaveAccount,
    'dont_have_account': dontHaveAccount,
    'full_name': fullName,
    'email_field': email,
    'password_field': password,
    'confirm_password': confirmPassword,
    'forgot_password': forgotPassword,
    'remember_me': rememberMe,
    'enter_full_name': enterFullName,
    'enter_email': enterEmail,
    'create_password': createPassword,
    'enter_password': enterPassword,
    'create_account_button': createAccountButton,
    'continue_with_google': continueWithGoogle,
    'continue_with_apple': continueWithApple,
    'sign_up_with_google': signUpWithGoogle,
    'sign_up_with_apple': signUpWithApple,
    'or_continue_with': orContinueWith,
    'or_sign_up_with': orSignUpWith,
    'agree_to_terms': agreeToTerms,
    'terms_and_conditions': termsAndConditions,
    'and': and,
    'privacy_policy': privacyPolicy,
    'required_field': requiredField,
    'valid_email': validEmail,
    'name_too_short': nameTooShort,
    'password_too_short': passwordTooShort,
    'passwords_do_not_match': passwordsDoNotMatch,
    'loading': loading,
    'authenticating': authenticating,
    'creating_account': creatingAccount,
    'authentication_failed': authenticationFailed,
    'invalid_credentials': invalidCredentials,
    'network_error': networkError,
    'unknown_error': unknownError,
    'back': back,
    'cancel': cancel,
    'done': done,
    'skip': skip,
    'next': next,
    'retry': retry,
    'login_successful': loginSuccessful,
    'registration_successful': registrationSuccessful,
    'okay': 'Okay',
    'dismiss': 'Dismiss',
    'change_language': 'Change Language',
    'english': 'English',
    'indonesian': 'Bahasa Indonesia',
  };

  Map<String, String> get indonesianStrings => {
    'app_name': 'KataDia',
    'welcome': 'Selamat Datang di KataDia',
    'tagline': 'Pelajari Bahasa Indonesia & Inggris dengan feedback pengucapan berbasis AI',
    'sign_in': 'Masuk',
    'sign_up': 'Daftar',
    'create_account': 'Buat Akun',
    'already_have_account': 'Sudah punya akun?',
    'dont_have_account': 'Belum punya akun?',
    'full_name': 'Nama Lengkap',
    'email_field': 'Email',
    'password_field': 'Kata Sandi',
    'confirm_password': 'Konfirmasi Kata Sandi',
    'forgot_password': 'Lupa Kata Sandi?',
    'remember_me': 'Ingat saya',
    'enter_full_name': 'Masukkan nama lengkap Anda',
    'enter_email': 'Masukkan email Anda',
    'create_password': 'Buat kata sandi',
    'enter_password': 'Masukkan kata sandi Anda',
    'create_account_button': 'Buat Akun',
    'continue_with_google': 'Lanjutkan dengan Google',
    'continue_with_apple': 'Lanjutkan dengan Apple',
    'sign_up_with_google': 'Daftar dengan Google',
    'sign_up_with_apple': 'Daftar dengan Apple',
    'or_continue_with': 'Atau lanjutkan dengan',
    'or_sign_up_with': 'Atau daftar dengan',
    'agree_to_terms': 'Saya setuju dengan ',
    'terms_and_conditions': 'Syarat dan Ketentuan',
    'and': ' dan ',
    'privacy_policy': 'Kebijakan Privasi',
    'required_field': 'Harap masukkan',
    'valid_email': 'Harap masukkan email yang valid',
    'name_too_short': 'Nama harus minimal 2 karakter',
    'password_too_short': 'Kata sandi harus minimal 8 karakter',
    'passwords_do_not_match': 'Kata sandi tidak cocok',
    'loading': 'Memuat...',
    'authenticating': 'Mengautentikasi...',
    'creating_account': 'Membuat akun...',
    'authentication_failed': 'Autentikasi gagal',
    'invalid_credentials': 'Email atau kata sandi salah',
    'network_error': 'Terjadi kesalahan jaringan',
    'unknown_error': 'Terjadi kesalahan yang tidak diketahui',
    'back': 'Kembali',
    'cancel': 'Batal',
    'done': 'Selesai',
    'skip': 'Lewati',
    'next': 'Lanjut',
    'retry': 'Coba Lagi',
    'login_successful': 'Login berhasil',
    'registration_successful': 'Akun berhasil dibuat',
    'okay': 'OK',
    'dismiss': 'Tutup',
    'change_language': 'Ubah Bahasa',
    'english': 'English',
    'indonesian': 'Bahasa Indonesia',
  };

  // Dynamic getter for any string
  String getString(String key) {
    return _getString(key, englishStrings, indonesianStrings);
  }
}

// Localizations delegate
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'id'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

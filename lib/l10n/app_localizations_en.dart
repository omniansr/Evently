// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get doNotHaveAccount => 'Don’t have an account?';

  @override
  String get loginToYourAccount => 'Login to your account';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get invalidPassword => 'Invalid password';

  @override
  String get or => 'Or';

  @override
  String get loginWithGoogle => 'Login with Google';
}

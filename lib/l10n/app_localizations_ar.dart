// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get register => 'إنشاء حساب';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get doNotHaveAccount => 'ليس لديك حساب؟';

  @override
  String get loginToYourAccount => 'الدخول إلى حسابك';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get invalidEmail => 'البريد الإلكتروني خاطئ';

  @override
  String get enterYourPassword => 'أدخل كلمة السر';

  @override
  String get invalidPassword => 'كلمة لسر خاطئة';

  @override
  String get or => 'أو';

  @override
  String get loginWithGoogle => 'تسجيل الدخول بحساب جوجل';
}

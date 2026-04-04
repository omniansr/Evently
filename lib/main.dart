import 'package:evently/app_theme.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/details_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/onboarding_screen.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/setting_Provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool onBoarding = prefs.getBool('onBoarding') ?? false;
  SettingProvider settingProvider = SettingProvider();
  await settingProvider.loadSettings();

  await Firebase.initializeApp(
  );
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => EventProvider()..getEvents()),
      ChangeNotifierProvider(create: (_) => SettingProvider()),

  ]
      ,child: evently(onBoarding: onBoarding, language: '', theme: '',)));
}

class evently extends StatelessWidget {

  final bool onBoarding;
  final String language;
  final String theme;



  evently({required this.onBoarding ,required this.language,required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingProvider.languageCode),
      routes: {
        HomeScreen.routename: (_) => HomeScreen(),
        OnboardingScreen.routename:(_) => OnboardingScreen(),
        StartScreen.routename:(_) => StartScreen(),
        RegisterScreen.routename:(_) => RegisterScreen(),
        LoginScreen.routename:(_) => LoginScreen(),
        CreateEventScreen.routename:(_) => CreateEventScreen(),
        DetailsScreen.routename:(_) => DetailsScreen(),
      },
      initialRoute: onBoarding ? RegisterScreen.routename : StartScreen.routename,
    );
  }
}



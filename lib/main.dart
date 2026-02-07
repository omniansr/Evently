import 'package:evently/app_theme.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/onboarding_screen.dart';
import 'package:evently/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool onBoarding = prefs.getBool('onBoarding') ?? false;
  runApp(evently(onBoarding: onBoarding));
}

class evently extends StatelessWidget {

  final bool onBoarding;

  evently({required this.onBoarding});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routes: {HomeScreen.routename: (_) => HomeScreen(),
        OnboardingScreen.routename:(_) => OnboardingScreen(),
        StartScreen.routename:(_) => StartScreen()},
      initialRoute: onBoarding ? HomeScreen.routename : StartScreen.routename,
    );
  }
}

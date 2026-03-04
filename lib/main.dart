import 'package:evently/app_theme.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/details_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/onboarding_screen.dart';
import 'package:evently/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool onBoarding = prefs.getBool('onBoarding') ?? false;
  await Firebase.initializeApp();
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
      themeMode: ThemeMode.dark,
      routes: {
        HomeScreen.routename: (_) => HomeScreen(),
        OnboardingScreen.routename:(_) => OnboardingScreen(),
        StartScreen.routename:(_) => StartScreen(),
        RegisterScreen.routename:(_) => RegisterScreen(),
        LoginScreen.routename:(_) => LoginScreen(),
        CreateEventScreen.routename:(_) => CreateEventScreen(),
        DetailsScreen.routename:(_) => DetailsScreen(),
      },
      initialRoute: onBoarding ? HomeScreen.routename : StartScreen.routename,
    );
  }
}



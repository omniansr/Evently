import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider with ChangeNotifier{

  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';

  bool get isDark => themeMode == ThemeMode.dark;

  Future<void> changeTheme(ThemeMode theme) async {
    if (themeMode == theme) return;

    themeMode = theme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'themeMode',
      theme == ThemeMode.dark ? 'dark' : 'light',
    );

    notifyListeners();
  }

  Future<void> changeLanguage(String language) async {
    if(language == languageCode) return;
    languageCode = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', language);

    notifyListeners();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    languageCode = prefs.getString('languageCode') ?? 'en';

    String savedTheme = prefs.getString('themeMode') ?? 'light';
    themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

}
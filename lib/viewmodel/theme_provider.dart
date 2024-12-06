import 'package:call_me_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightTheme;
  ThemeData get theme => _theme;

  void getTheme() async {
    const storage = FlutterSecureStorage();
    String themeMode = await storage.read(key: 'theme') ?? 'light';
    if (themeMode == 'light') {
      _theme = lightTheme;
      await storage.write(key: 'theme', value: 'light');
    } else {
      _theme = darkTheme;
      await storage.write(key: 'theme', value: 'dark');
    }
    notifyListeners();
  }

  void toggleTheme() async {
    const storage = FlutterSecureStorage();

    if (_theme == lightTheme) {
      _theme = darkTheme;
      await storage.write(key: 'theme', value: 'dark');
    } else {
      _theme = lightTheme;
      await storage.write(key: 'theme', value: 'light');
    }
    notifyListeners();
  }
}

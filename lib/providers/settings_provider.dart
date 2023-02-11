import 'package:flutter/cupertino.dart';

enum AppTheme { dark, light }

class SettingsProvider extends ChangeNotifier {
  AppTheme _appTheme = AppTheme.dark;

  AppTheme get appTheme => _appTheme;

  void setAppTheme(AppTheme appTheme) {
    _appTheme = appTheme;
    notifyListeners();
  }
}

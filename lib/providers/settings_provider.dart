import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';

enum AppTheme { dark, light }

class SettingsProvider extends ChangeNotifier {
  // AppTheme _appTheme = AppTheme.dark;
  // bool _isAutoReadAloud = false;

  AppTheme get appTheme {
    if (settingsBox.get(
          'isDarkTheme',
          defaultValue: false,
        ) ==
        true) {
      return AppTheme.dark;
    }
    return AppTheme.light;
  }

  bool get isAutoReadAloud {
    if (settingsBox.get('isReadAloud', defaultValue: true)) {
      return true;
    }
    return false;
  }

  void setAppTheme(AppTheme appTheme) async {
    // _appTheme = appTheme;
    await settingsBox.put(
      'isDarkTheme',
      appTheme == AppTheme.dark ? true : false,
    );
    notifyListeners();
  }

  void setAutoRead(bool autoRead) async {
    // _isAutoReadAloud = autoRead;
    await settingsBox.put('isReadAloud', autoRead);
    notifyListeners();
  }

  Future<void> deleteConversation() async {
    await messagesBox.clear();
    await conversationBox.clear();
    notifyListeners();
  }
}

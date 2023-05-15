import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColorProvider with ChangeNotifier {
  var _themeModes = ThemeMode.light;
  ThemeMode get themeMode => _themeModes;

  void SetTheme(themeMode) {
    _themeModes = themeMode;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.dark;
  String colorIndex = "purple";
  Color _primaryColor = Colors.deepPurple;

  ThemeNotifier({@required this.colorIndex});

  set theme(value) {
    _theme = value;
    notifyListeners();
  }

  set primaryColor(value) {
    _primaryColor = value;
    notifyListeners();
  }

  ThemeMode get theme => _theme;
  Color get primaryColor => _primaryColor;
}

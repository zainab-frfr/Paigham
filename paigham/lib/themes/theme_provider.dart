import 'package:flutter/material.dart';
import 'package:paigham/themes/dark_mode.dart';
import 'package:paigham/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _theme = lightmode;

  ThemeData getThemeData() => _theme;

  bool get isDarkMode => _theme == darkmode;

  void toggleTheme(){
    if(_theme == lightmode){
      _theme = darkmode;
    }else{
      _theme = lightmode;
    }
    notifyListeners();
  }

}
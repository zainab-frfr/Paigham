import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paigham/themes/dark_mode.dart';
import 'package:paigham/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{

  final Box box = Hive.box('myBox');
  String strMode = 'light';

  ThemeData _theme = lightmode;

  void _saveData() {
    box.put('theme', strMode);
  }

  ThemeData loadData() {
    strMode = box.get('theme', defaultValue: 'light');
    if(strMode == 'light'){
      _theme = lightmode;
      return _theme;
    }else{
      _theme = darkmode;
      return _theme;
    }
  }

  ThemeData getThemeData() => _theme;

  bool get isDarkMode => _theme == darkmode;

  void toggleTheme(){
    if(_theme == lightmode){
      _theme = darkmode;
      strMode = 'dark';
    }else{
      _theme = lightmode;
      strMode = 'light';
    }
    _saveData();
    notifyListeners();
  }

}
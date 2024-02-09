import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class Favourite {
  static const FAVOURITE_KEY = "favourite_key";

  getFavourite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(FAVOURITE_KEY) ?? '';
  }
}

class MyThemePreferences {
  static const THEME_KEY = "theme_key";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }
}

class MyLangPreferences {
  static const LANG_KEY = "lang_key";

  setLan(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(LANG_KEY, value);
  }

  getLan() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(LANG_KEY) ?? 'english';
  }
}

class ModelTheme extends ChangeNotifier {
  String _lang = "english";
  late bool _isDark;
  late MyLangPreferences _langPreferences;
  late MyThemePreferences _preferences;

  String get isLang => _lang;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false;
    _preferences = MyThemePreferences();
    modelLang();
    getPreferences();
  }

  modelLang() {
    _langPreferences = MyLangPreferences();
  }

  set Lang(String value) {
    if (value == "english") {
      _lang = "gujrati";
    } else {
      _lang = "english";
    }

    notifyListeners();
    _langPreferences.setLan(_lang);
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    _lang = await _langPreferences.getLan();
    notifyListeners();
  }
}



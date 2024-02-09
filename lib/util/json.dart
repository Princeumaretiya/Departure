import 'dart:ui';


String langValue = "gujrati";

void changeLang() {
  langValue == "english" ? langValue = "gujrati" : langValue = "english";
}

var newLocale = const Locale('en', 'US');
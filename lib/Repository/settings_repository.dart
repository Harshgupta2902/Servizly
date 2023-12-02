
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LanguageModel/setting.dart';


ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();


Future<Setting> initSettings() async {
  Setting _setting = Setting();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    _setting.mobileLanguage.value = Locale(prefs.get('language').toString(), '');
  }

  _setting.brightness.value = prefs.getBool('isDark') ?? false
      ? Brightness.dark
      : Brightness.light;
  setting.value = _setting;
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

  setting.notifyListeners();

  return setting.value;
}

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (brightness == Brightness.dark) {
    prefs.setBool("isDark", true);
    brightness = Brightness.dark;
  } else {
    prefs.setBool("isDark", false);
    brightness = Brightness.light;
  }
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = prefs.getString('language').toString();
  }
  return defaultLanguage;
}

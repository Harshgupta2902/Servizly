
import 'package:flutter/material.dart';

class Setting {

  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

}

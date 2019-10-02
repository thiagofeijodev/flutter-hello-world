import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

import 'preferences.dart';

const List<String> _kSupportedLanguages = ["en","pt"];
const String _kDefaultLanguage = "pt";

GlobalTranslations allTranslations = GlobalTranslations();

class GlobalTranslations {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;

  Iterable<Locale> supportedLocales() => _kSupportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  String text(String key) {
    String string = '** $key not found';

    return (_localizedValues == null || _localizedValues[key] == null) ? string : _localizedValues[key];
  }

  String get currentLanguage => _locale == null ? '' : _locale.languageCode;
  Locale get locale => _locale;
  
  Future<Null> init() async {
    if (_locale == null){
      await setNewLanguage();
    }
    return null;
  }

  Future<Null> setNewLanguage([String newLanguage]) async {
    String language = newLanguage;
    if (language == null){
      language = await preferences.getPreferredLanguage();
    }

    if (language == ''){
      String currentLocale;
      try {
        currentLocale = ui.window.locale.languageCode;
        if (currentLocale.length > 2){
          if (currentLocale[2] == "-" || currentLocale[2] == "_"){
            currentLocale = currentLocale.substring(0, 2);
          }
        }

        language = currentLocale;
      } catch (Exception) {
        language = _kDefaultLanguage;
      }
    }
    
    if (!_kSupportedLanguages.contains(language)){
      language = _kDefaultLanguage;
    }
    
    _locale = Locale(language, "");

    String jsonContent = await rootBundle.loadString("locale/locale_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);

    return null;
  }

  static final GlobalTranslations _translations = GlobalTranslations._internal();
  factory GlobalTranslations() {
    return _translations;
  }
  GlobalTranslations._internal();
}

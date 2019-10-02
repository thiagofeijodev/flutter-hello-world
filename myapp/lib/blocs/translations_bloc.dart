import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/services/bloc_provider.dart';

import 'package:myapp/services/translations.dart';
import 'package:myapp/services/preferences.dart';

class TranslationsBloc implements BlocBase {
  StreamController<String> _languageController = StreamController<String>();
  Stream<String> get currentLanguage => _languageController.stream;

  StreamController<Locale> _localeController = StreamController<Locale>();
  Stream<Locale> get currentLocale => _localeController.stream;

  @override
  void dispose() {
    _languageController?.close();
    _localeController?.close();
  }

  void setNewLanguage(String newLanguage) async {
    await preferences.setPreferredLanguage(newLanguage);
    
    await allTranslations.setNewLanguage(newLanguage);

    _languageController.sink.add(newLanguage);
    _localeController.sink.add(allTranslations.locale);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

import 'localizations.dart';

void main() {
  runApp(new Application());
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => new _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
        const Locale('en'),
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        try {
          var languageCode = ui.window.locale.languageCode;
          debugPrint('localeResolutionCallback() $languageCode');

          return Locale(languageCode);
        } catch (Exception) {
          return Locale('pt');
        }
      },
      home: DemoApp()
    );
  }
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context).title),
      ),
    );
  }
}

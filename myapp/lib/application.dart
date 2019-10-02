import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'services/translations.dart';
import 'services/bloc_provider.dart';
import 'views/demo_view.dart';
import 'blocs/translations_bloc.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => new _ApplicationState();
}

class _ApplicationState extends State<Application> {
  TranslationsBloc translationsBloc;

  @override
  void initState() {
    super.initState();
    translationsBloc = TranslationsBloc();
  }

  @override
  void dispose() {
    translationsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TranslationsBloc>(
      bloc: translationsBloc,
      child: StreamBuilder<Locale>(
        stream: translationsBloc.currentLocale,
        initialData: allTranslations.locale,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
          return MaterialApp(
            title: 'Application Title',
            locale: snapshot.data ?? allTranslations.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: allTranslations.supportedLocales(),
            home: Scaffold(
              appBar: AppBar(
                title: Text(allTranslations.text('title')),
              ),
              body: DemoApp()
            )
          );
        }
      ),
    );
  }
}
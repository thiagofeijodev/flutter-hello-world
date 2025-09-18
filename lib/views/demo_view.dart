import 'package:flutter/material.dart';

import 'package:myapp/services/translations.dart';
import 'package:myapp/blocs/translations_bloc.dart';
import 'package:myapp/services/bloc_provider.dart';

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => new _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;

    final String pageTitle = allTranslations.text("title");

    final TranslationsBloc translationsBloc = BlocProvider.of<TranslationsBloc>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text(pageTitle),
            onPressed: () async {
              
              //await allTranslations.setNewLanguage(language == 'pt' ? 'en' : 'pt');
              //setState((){});
              translationsBloc.setNewLanguage(language == 'pt' ? 'en' : 'pt');
            },
          ),
          Text(pageTitle),
        ],
      ),
    );
  }
}
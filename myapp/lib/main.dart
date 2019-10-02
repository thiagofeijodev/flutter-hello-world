import 'package:flutter/material.dart';

import 'services/translations.dart';
import 'application.dart';

void main() async {
  await allTranslations.init();

  runApp(new Application());
}

# myapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


For generate files to i18n

```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/main.dart
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n --no-use-deferred-loading lib/main.dart lib/i18n/intl_*.arb
```

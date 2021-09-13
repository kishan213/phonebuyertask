import 'dart:async';
import 'package:flutter/material.dart';
import 'localization_en.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'km'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LocalizationEN();
      default:
        return LocalizationEN();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}

abstract class Localization {
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization)!;
  }

  String get appName;

  String get aboutDevice;
  String get devicePrice;
  String get deviceRating;
  String get brandName;
  String get short;
  String get priceLowToHigh;
  String get priceHighToLow;
  String get clear;
  String get noDeviceFound;
}

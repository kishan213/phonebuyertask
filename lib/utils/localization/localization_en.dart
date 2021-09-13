import 'localization.dart';

class LocalizationEN implements Localization {
  @override
  String get appName => "Phone Shop";

  @override
  String get aboutDevice => "About Device";

  @override
  String get brandName => "Brand Name";

  @override
  String get clear => "CLEAR";

  @override
  String get priceHighToLow => "HIGH TO LOW(PRICE)";

  @override
  String get priceLowToHigh => "LOW TO HIGH(PRICE)";

  @override
  String get short => "Sort";

  @override
  String get noDeviceFound => "No Device Found";

  @override
  String get devicePrice => "Price";

  @override
  String get deviceRating => "Rating";
}

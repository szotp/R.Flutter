import 'package:r_flutter/src/utils/utils.dart';

class Locale {
  final String languageCode;
  final String countryCode;
  final String scriptCode;

  Locale(this.languageCode, [this.countryCode]) : scriptCode = null;

  Locale.fromSubtags({
    this.languageCode,
    this.scriptCode,
    this.countryCode,
  });

  @override
  String toString() {
    if (countryCode == null && scriptCode == null) {
      return languageCode;
    }
    if (scriptCode == null) {
      return "${languageCode}_$countryCode";
    }
    if (countryCode == null) {
      return "${languageCode}_$scriptCode";
    }
    return "${languageCode}_${scriptCode}_$countryCode";
  }

  static Locale fromJson(Map<String, dynamic> map) => Locale.fromSubtags(
        languageCode: map.get('languageCode'),
        scriptCode: map.get('scriptCode'),
        countryCode: map.get('countryCode'),
      );

  dynamic toJson() => {
        'languageCode': languageCode,
        'countryCode': countryCode,
        'scriptCode': scriptCode,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Locale &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode &&
          countryCode == other.countryCode &&
          scriptCode == other.scriptCode;

  @override
  int get hashCode => toString().hashCode;
}

class I18nLocales {
  final Locale defaultLocale;
  final List<I18nLocale> locales;

  I18nLocales(this.defaultLocale, this.locales);

  I18nLocale get defaultValues => locales.firstWhere((locale) => locale.locale == defaultLocale);

  static I18nLocales fromJson(Map<String, dynamic> json) => I18nLocales(
        Locale.fromJson(json['defaultLocale'] as Map<String, dynamic>),
        (json['locales'] as List).map((e) => I18nLocale.fromJson(e as Map<String, dynamic>)).toList(),
      );

  dynamic toJson() => {'defaultLocale': defaultLocale, 'locales': locales};
}

class I18nLocale {
  final Locale locale;
  final List<I18nString> strings;

  I18nLocale(this.locale, this.strings);

  static I18nLocale fromJson(Map<String, dynamic> json) => I18nLocale(
        json.get('locale', Locale.fromJson),
        json.getList('strings', I18nString.fromJson),
      );

  dynamic toJson() => {'locale': locale, 'strings': strings};
}

class I18nString {
  final String key;
  final String value;
  final List<String> placeholders;

  bool get hasPlaceholders => placeholders.isNotEmpty;

  I18nString({this.key, this.value, this.placeholders = const []});

  String get escapedKey => key.replaceAll(".", "_");

  static I18nString fromJson(Map<String, dynamic> json) => I18nString(
        key: json.get('key'),
        value: json.get('value'),
        placeholders: json.getList('placeholders'),
      );

  dynamic toJson() => {'key': key, 'value': value, 'placeholders': placeholders};
}

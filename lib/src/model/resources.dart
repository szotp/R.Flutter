import 'package:r_flutter/src/generator/generator.dart';
import 'package:r_flutter/src/model/i18n.dart';
import 'package:r_flutter/src/parser/fonts_parser.dart';
import 'package:r_flutter/src/utils/utils.dart';

class Resources {
  final List<Font> fonts;
  final Assets assets;
  final I18nLocales i18n;

  Resources({
    this.fonts,
    this.assets,
    this.i18n,
  });

  static Resources fromJson(Map<String, dynamic> json) => Resources(
        fonts: json.getList('fonts', Font.fromJson),
        assets: json.get('assets', Assets.fromJson),
        i18n: json.get('i18n', I18nLocales.fromJson),
      );

  Map<String, dynamic> toJson() => {
        'fonts': fonts,
        'assets': assets,
        'i18n': i18n,
      };
}

class Assets {
  /// Actually found asset files
  final List<Asset> assets;

  /// Asset paths as declared in pubspec, minus the ignored ones
  final List<String> declared;

  Set<String> get imports => assets
      .map((e) {
        final type = e.type;
        if (type is CustomAssetType) {
          return type.import;
        } else {
          return null;
        }
      })
      .where((element) => element != null)
      .toSet();

  const Assets(this.assets, this.declared);

  static const empty = Assets([], []);

  static Assets fromJson(Map<String, dynamic> json) => Assets(
        json.getList('assets', Asset.fromJson),
        json.getList('declared'),
      );

  Map<String, dynamic> toJson() => {
        'assets': assets,
        'declared': declared,
      };
}

extension Lol on Asset {}

class Asset {
  final String name;
  final String path;
  final String fileUri;
  final AssetType type;

  String get nameSanitized => createVariableName(name);

  Asset({
    this.name,
    this.path,
    this.fileUri,
    this.type,
  });

  Asset copyWith({
    String name,
    String path,
    String fileUri,
    AssetType type,
  }) {
    return Asset(
        name: name ?? this.name, path: path ?? this.path, fileUri: fileUri ?? this.fileUri, type: type ?? this.type);
  }

  @override
  String toString() {
    return "Asset(name: $name, path: $path)";
  }

  @override
  bool operator ==(dynamic other) {
    return other is Asset && other.fileUri == fileUri;
  }

  @override
  int get hashCode => fileUri.hashCode;

  static Asset fromJson(Map<String, dynamic> json) => Asset(
        name: json.get('name'),
        path: json.get('path'),
        fileUri: json.get('fileUri'),
        type: json.get('type', AssetType.fromJson),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'path': path,
        'fileUri': fileUri,
        'type': type,
      };
}

class AssetType {
  final String key;

  const AssetType(this.key);

  static const image = AssetType('AssetImage');
  static const stringPath = AssetType('');

  static AssetType fromJson(dynamic value) {
    if (value is String) {
      return image.key == value ? image : stringPath;
    }
    return CustomAssetType.fromJson(value as Map<String, dynamic>);
  }

  dynamic toJson() => key;
}

class CustomAssetType extends AssetType {
  final String extension;
  final String customClass;
  final String import;

  static const defaultImport = 'asset_classes.dart';

  const CustomAssetType(this.customClass, this.extension, this.import) : super(customClass);

  static CustomAssetType fromJson(Map<String, dynamic> json) => CustomAssetType(
        json['customclass'] as String,
        json['customClass'] as String,
        json['import'] as String,
      );

  @override
  Map<String, dynamic> toJson() => {
        'extension': extension,
        'customClass': customClass,
        'import': import,
      };
}

class StringReference {
  final String name;
  final List<String> placeholders;
  final String value;

  StringReference({
    this.name,
    this.placeholders,
    this.value,
  });

  static StringReference fromJson(Map<String, dynamic> json) => StringReference(
        name: json['name'] as String,
        placeholders: (json['placeholders'] as List).cast(),
        value: json['value'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'placeholders': placeholders,
        'value': value,
      };
}

//ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, camel_case_types, unnecessary_string_escapes

import 'package:flutter/widgets.dart';

import 'asset_classes.dart';

class Assets {
  /// lib/assets/extension.png Instance of &#x27;AssetType&#x27;
  static const extension = AssetImage('lib/assets/extension.png');

  /// lib/assets/sub/sub/test_asset.txt Instance of &#x27;AssetType&#x27;
  static const subSubTestAsset = ('lib/assets/sub/sub/test_asset.txt');

  /// lib/assets/sub/test_asset.txt Instance of &#x27;AssetType&#x27;
  static const assetsSubTestAsset = ('lib/assets/sub/test_asset.txt');

  /// lib/assets/sub/temp.txt Instance of &#x27;AssetType&#x27;
  static const temp = ('lib/assets/sub/temp.txt');

  /// lib/assets/sub2/sub2.txt Instance of &#x27;AssetType&#x27;
  static const sub2 = ('lib/assets/sub2/sub2.txt');

  /// lib/assets/svg.svg Instance of &#x27;CustomAssetType&#x27;
  static const svg = SvgFile('lib/assets/svg.svg');

  /// lib/assets/test_asset2.txt Instance of &#x27;AssetType&#x27;
  static const testAsset2 = ('lib/assets/test_asset2.txt');

  /// lib/assets/äßet.txt Instance of &#x27;AssetType&#x27;
  static const aesset = ('lib/assets/äßet.txt');
}

class I18nData {
  String getString(String key, [Map<String, String> placeholders]) {
    return null;
  }
}

class I18n {
  I18nData data;

  static const appNameKey = 'appName';
  /** AppName */
  String get appName => data.getString(appNameKey);

  static const string1Key = 'string1';
  /** Content */
  String get string1 => data.getString(string1Key);

  static const stringWithPlaceholderKey = 'stringWithPlaceholder';
  /** String with {placeholder} */
  String stringWithPlaceholder(
    String placeholder,
  ) {
    return data.getString(
      stringWithPlaceholderKey,
      {
        'placeholder': placeholder,
      },
    );
  }

  static const stringWithPlaceholdersKey = 'stringWithPlaceholders';
  /** String with {placeholder1} {placeholder2} */
  String stringWithPlaceholders(
    String placeholder1,
    String placeholder2,
  ) {
    return data.getString(
      stringWithPlaceholdersKey,
      {
        'placeholder1': placeholder1,
        'placeholder2': placeholder2,
      },
    );
  }

  static const helloKey = 'hello';
  /** Hola */
  String get hello => data.getString(helloKey);

  static const withLineBreakKey = 'withLineBreak';
  /** test

lint
break */
  String get withLineBreak => data.getString(withLineBreakKey);

  static const hello_thereKey = 'hello_there';
  /** hello_there */
  String get hello_there => data.getString(hello_thereKey);
}

class Fonts {
  static const testFont = 'TestFont';
}

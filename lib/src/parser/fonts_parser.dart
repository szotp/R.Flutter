import 'package:r_flutter/src/generator/generator.dart';
import 'package:r_flutter/src/utils/utils.dart';
import 'package:yaml/yaml.dart';

class Font {
  String get key => createVariableName(name);
  final String name;

  Font(this.name);

  dynamic toJson() => {
        'key': key,
        'name': name,
      };

  static Font fromJson(Map<String, dynamic> json) {
    return Font(json.get('name'));
  }
}

List<Font> parseFonts(YamlMap yaml) {
  final flutter = yaml["flutter"];
  if (flutter == null) {
    return [];
  }

  final fonts = safeCast<List>(flutter["fonts"]);
  if (fonts == null) {
    return [];
  }

  return fonts.map((item) => safeCast<String>(item["family"])).where((it) => it != null).map((e) => Font(e)).toList();
}

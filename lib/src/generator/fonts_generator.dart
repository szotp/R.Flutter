import 'package:r_flutter/src/model/dart_class.dart';
import 'package:r_flutter/src/parser/fonts_parser.dart';

DartClass generateFontClass(List<Font> fonts) {
  if (fonts.isEmpty) {
    return null;
  }
  final classString = StringBuffer("class Fonts {\n");
  for (final font in fonts) {
    classString.writeln("  static const String ${font.key} = \"${font.name}\";");
  }
  classString.writeln("}");
  return DartClass(code: classString.toString());
}

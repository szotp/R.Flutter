import 'dart:convert';
import 'dart:io';

import 'package:mustache/mustache.dart';
import 'package:r_flutter/src/model/resources.dart';
import 'package:r_flutter/src/template.dart';

// ignore_for_file: unused_import
import '../bin/generate.dart' as m;

Future<void> main() async {
  // Directory.current = 'example';
  // m.main([]);

  final template = Template(templateString);
  final jsonFile = File('test/resources.json');
  final jsonObject = jsonDecode(jsonFile.readAsStringSync()) as Map<String, dynamic>;
  final model = Resources.fromJson(jsonObject);

  final render = template.renderString(model);
  File('test/resources.dart').writeAsStringSync(render);
}

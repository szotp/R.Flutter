#!/usr/bin/env dart
import 'dart:io';

import 'package:r_flutter/builder.dart';
import 'package:r_flutter/src/generator/generator.dart';
import 'package:yaml/yaml.dart';

main(List<String> args) {
  final pubspec = File('pubspec.yaml');

  if (!pubspec.existsSync()) {
    print('pubspec does not exist');
    exit(-1);
  }

  final configRaw = loadYaml(pubspec.readAsStringSync());
  final arguments = parseYamlArguments(configRaw ?? YamlMap());

  // TODO: should be changeable
  arguments.outputFilename = 'lib/r.g.dart';

  final res = parseResources(arguments);
  final contents = generateFile(res, arguments);

  final outoutFile = File(arguments.outputFilename);
  outoutFile.writeAsStringSync(contents);

  print("${outoutFile.path} generated successfully");
}

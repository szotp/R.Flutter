#!/usr/bin/env dart

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:args/args.dart';
import 'package:mustache/mustache.dart';
import 'package:r_flutter/builder.dart';
import 'package:r_flutter/src/arguments.dart';
import 'package:r_flutter/src/template.dart';
import 'package:r_flutter/src/utils/utils.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) {
  final arguments = CommandLineArguments()..parse(args);

  final configRaw = safeCast<YamlMap>(loadYaml(File(arguments.pubspecFilename).absolute.readAsStringSync()));
  final config = Config.parsePubspecConfig(configRaw ?? YamlMap());

  final res = parseResources(config);

  const encoder = JsonEncoder.withIndent('  ');
  log(encoder.convert(res));

  final outoutFile = File(arguments.outputFilename);
  //outoutFile.writeAsStringSync(contents);

  // ignore: avoid_print
  print("${outoutFile.path} generated successfully");
}

class CommandLineArguments {
  String pubspecFilename;
  String outputFilename;

  void parse(List<String> args) {
    ArgParser()
      ..addOption(
        "pubspec-file",
        defaultsTo: 'pubspec.yaml',
        callback: (value) => pubspecFilename = safeCast(value),
        help: 'Specify the pubspec file.',
      )
      ..addOption(
        "output-file",
        defaultsTo: 'lib/assets.dart',
        callback: (value) => outputFilename = safeCast(value),
        help: 'Specify the output file.',
      )
      ..parse(args);
  }
}

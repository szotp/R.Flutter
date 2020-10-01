import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:mustache/mustache.dart';
import 'package:watcher/watcher.dart';

import '../bin/generate.dart' as m;

Future<void> main() async {
  Directory.current = 'example';
  final uri = await Isolate.resolvePackageUri(Uri.parse('package:r_flutter/template.mustache'));
  final model = m.parseResourcesFromArgs([]);
  Directory.current = '..';

  void render() {
    try {
      final templateString = File(uri.path).readAsStringSync();
      final template = Template(templateString);
      final render = template.renderString(model);
      File('example/lib/assets_next.dart').writeAsStringSync(render);
      log('Rendered!');
    } catch (e, st) {
      log('$e');
    }
  }

  render();

  final watcher = FileWatcher(uri.path);
  watcher.events.listen((event) {
    render();
    log('$event');
  });
}

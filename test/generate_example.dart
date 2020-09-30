import 'dart:io';

import '../bin/generate.dart' as m;

Future<void> main() async {
  Directory.current = 'example';
  m.main([]);
}

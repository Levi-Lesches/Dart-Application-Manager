import "dart:io";

import "package:version/version.dart";

class App {
  final Version version;
  final String name;
  final Directory dir;

  App({
    required this.dir,
    required this.name,
    required this.version,
  });
}

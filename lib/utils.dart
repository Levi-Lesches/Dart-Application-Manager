import 'dart:io';

import 'package:yaml/yaml.dart';
import "package:path/path.dart" as p;

typedef Json = Map<String, dynamic>;

class LinuxUtils {
  static Directory get home => Directory(String.fromEnvironment("HOME", defaultValue: Directory.current.absolutePath));
  static String get user => String.fromEnvironment("USER", defaultValue: "user");
}

extension DirectoryUtils on Directory {
  String operator /(String other) => p.normalize("$absolutePath/$other");
}

extension FileDirUtils on FileSystemEntity {
  String get absolutePath => p.normalize(p.absolute(absolute.path));
}

extension JsonUtils on Json {
  T? maybe<T, V>(String key, T Function(V) transform) {
    final value = this[key];
    if (value == null) return null;
    return transform(value);
  }
}

extension YamlMapConverter on YamlMap {
  dynamic _convertNode(dynamic v) {
    if (v is YamlMap) {
      return v.toMap();
    }
    else if (v is YamlList) {
      var list = <dynamic>[];
      for (final e in v) {
        list.add(_convertNode(e));
      }
      return list;
    }
    else {
      return v;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    nodes.forEach((k, v) {
      final key = (k as YamlScalar).value.toString();
      map[key] = _convertNode(v.value);
    });
    return map;
  }
}

extension FileUtils on File {
  // isInstalled = exists && written by DAM
  // safeToWrite = !exists || written by DAM
  Future<bool> wasGeneratedByDam(String header) async {
    final contents = await readAsString();
    return contents.startsWith(header);
  }

  Future<bool> isInstalledByDam(String header) async =>
    existsSync() && (await wasGeneratedByDam(header));

  Future<bool> isSafeToWrite(String header) async =>
    !existsSync() || (await wasGeneratedByDam(header));
}

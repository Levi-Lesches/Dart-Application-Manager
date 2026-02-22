import 'dart:io';

import 'package:yaml/yaml.dart';
import "package:path/path.dart" as p;

typedef Json = Map<String, dynamic>;

extension DirectoryUtils on Directory {
  static Directory get home => Directory(String.fromEnvironment("HOME"));
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

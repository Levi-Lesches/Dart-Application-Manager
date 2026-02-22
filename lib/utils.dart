import 'dart:io';

import 'package:yaml/yaml.dart';

typedef Json = Map<String, dynamic>;

extension DirUtils on Directory {
  String operator /(String other) => "$path/$other";
}

extension JsonUtils on Json {
  T? maybe<T, V>(String key, T Function(V) transform) {
    final value = this[key];
    if (value == null) return null;
    return transform(value);
  }

  Json asJson(String key) => (this[key] as Map).cast<String, dynamic>();
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

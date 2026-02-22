import 'dart:convert';
import 'dart:io';

import 'package:dam/data.dart';
import 'package:dam/utils.dart';
import 'package:yaml/yaml.dart';

class Registry {
  Directory dir = Directory("~/.dam");  // all apps

  Future<List<App>> getApps() async {
    final file = File(dir / "apps.json");
    final jsonString = await file.readAsString();
    final json = (jsonDecode(jsonString) as List).cast<Json>();
    return [
      for (final appJson in json)
        App.fromJson(appJson),
    ];
  }

  Future<AppConfig> getConfig(App app) async {
    final file = File(app.dir / "dam.yaml");
    final contents = await file.readAsString();
    final yaml = loadYaml(contents) as Json;
    return AppConfig.fromJson(yaml);
  }
}

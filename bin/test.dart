import 'dart:io';

import 'package:dam/data.dart';
import 'package:dam/utils.dart';
import 'package:yaml/yaml.dart';

void main() async {
  final contents = await File("example.yaml").readAsString();
  final yaml = (await loadYaml(contents)) as YamlMap;
  final config = AppConfig.fromJson(yaml.toMap());
  print(config.cron?.interval);
}
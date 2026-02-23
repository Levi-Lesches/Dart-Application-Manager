import 'dart:io';

import 'package:dam/data.dart';
import 'package:dam/services.dart';
import 'package:dam/utils.dart';
import 'package:yaml/yaml.dart';

Future<void> install() async {
  final dir = Directory.current;
  final configFile = File(dir / "dam.yaml");
  if (!configFile.existsSync()) {
    throw DamError("No dam.yaml file found in the current directory");
  }
  final contents = await configFile.readAsString();
  final yaml = (loadYaml(contents) as YamlMap).toMap();
  final config = AppConfig.fromJson(yaml);
  final app = config.app;

  final registry = Registry();
  await registry.register(config.app);

  final cronConfig = config.cron;
  if (cronConfig != null) await CronService().install(app, cronConfig);

  final systemd = config.systemd;
  if (systemd != null) await SystemdService().install(app, systemd);

  final webConfig = config.webServer;
  if (webConfig != null) await CaddyService().install(app, webConfig);

  print("Installed ${app.name}");
}

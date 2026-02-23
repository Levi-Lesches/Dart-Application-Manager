import "dart:io";

import "package:dam/utils.dart";

import "app.dart";
import "cron.dart";
import "systemd.dart";
import "web_server.dart";

class AppConfig {
  final App app;
  final CronConfig? cron;
  final SystemdConfig? systemd;
  final WebServerConfig? webServer;

  AppConfig({
    required this.app,
    required this.cron,
    required this.systemd,
    required this.webServer,
  });

  AppConfig.fromJson(Directory dir, Json json) :
    app = App.fromConfig(dir, json),  // not a typo -- metadata is at the top level
    cron = json.maybe("cron", CronConfig.fromJson),
    systemd = json.maybe("systemd", SystemdConfig.fromJson),
    webServer = json.maybe("web-server", WebServerConfig.fromJson);
}

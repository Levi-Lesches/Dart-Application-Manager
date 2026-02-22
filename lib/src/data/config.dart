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

  AppConfig.fromJson(Json json) :
    app = App.fromJson(json),  // not a typo -- metadata is at the top level
    cron = CronConfig.fromJson(json["cron"]),
    systemd = SystemdConfig.fromJson(json["systemd"]),
    webServer = WebServerConfig.fromJson(json["web-server"]);
}

import "package:dam/utils.dart";

import "cron.dart";
import "systemd.dart";
import "web_server.dart";

class AppConfig {
  final CronConfig? cron;
  final SystemdConfig? systemd;
  final WebServerConfig? webServer;

  AppConfig({
    required this.cron,
    required this.systemd,
    required this.webServer,
  });

  AppConfig.fromJson(Json json) :
    cron = CronConfig.fromJson(json["cron"]),
    systemd = SystemdConfig.fromJson(json["systemd"]),
    webServer = WebServerConfig.fromJson(json["web-server"]);
}

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
}

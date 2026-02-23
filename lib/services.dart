import "package:dam/data.dart";
import "package:dam/src/services/config.dart";

import "";

export "src/services/caddy.dart";
export "src/services/cron.dart";
export "src/services/registry.dart";
export "src/services/service.dart";
export "src/services/systemd.dart";

class Services {
  final caddy = CaddyService();
  final cron = CronService();
  final systemd = SystemdService();
  final config = ConfigService();
  final registry = Registry();

  List<AppService> get _appServices => [caddy, cron, systemd];

  Future<void> install(AppConfig app, {required bool dryRun}) async {
    await registry.register(app.app, dryRun: dryRun);
    for (final service in _appServices) {
      final serviceConfig = service.getConfig(app);
      if (serviceConfig != null) await service.install(app.app, serviceConfig, dryRun: dryRun);
    }
  }

  Future<void> uninstall(AppConfig app, {required bool dryRun}) async {
    for (final service in _appServices) {
      final serviceConfig = service.getConfig(app);
      if (serviceConfig != null) await service.uninstall(app.app, dryRun: dryRun);
    }
    await registry.unregister(app.app, dryRun: dryRun);
  }
}

final services = Services();

import "package:collection/collection.dart";
import "package:dam/data.dart";
import "package:dam/services.dart";
import "package:dam/utils.dart";

Future<void> uninstall(String? name, {required bool dryRun}) async {
  final AppConfig config;
  if (name == null) {
    config = await services.config.readConfig();
  } else {
    final apps = await services.registry.getApps();
    final app = apps.firstWhereOrNull((other) => other.name == name);
    if (app == null) {
      logger.error("Could not find a registered app named $name");
      return;
    }
    config = await services.config.readConfig(app.dir);
  }

  await services.uninstall(config, dryRun: dryRun);
  logger.success("Uninstalled ${config.app.name}");
}

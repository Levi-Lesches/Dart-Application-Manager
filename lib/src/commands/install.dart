import "package:dam/services.dart";
import "package:dam/utils.dart";

Future<void> install({required bool dryRun}) async {
  final config = await services.config.readConfig();

  await services.install(config, dryRun: dryRun);

  logger.success("Installed ${config.app.name}");
}

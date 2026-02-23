import "dart:convert";
import "dart:io";

import "package:dam/data.dart";
import "package:dam/utils.dart";

import "service.dart";

class Registry {
  static final file = File(AppService.root / "apps.json");
  Future<List<App>> getApps() async {
    if (!file.existsSync()) return [];
    final jsonString = await file.readAsString();
    final json = (jsonDecode(jsonString) as List).cast<Json>();
    return [
      for (final appJson in json)
        App.fromRegistry(appJson),
    ];
  }

  Future<void> _save(List<App> apps, {required bool dryRun}) async {
    const encoder = JsonEncoder.withIndent("  ");
    final contents = encoder.convert(apps);
    logger.debug("Updating registry at ${file.absolutePath}");
    logger.logFileContent(contents);
    if (!dryRun) {
      await file.create();
      await file.writeAsString(contents);
    }
  }

  Future<void> register(App app, {required bool dryRun}) async {
    logger.info("Registering $app in the DAM registry");
    final apps = await getApps();
    apps.add(app);
    await _save(apps, dryRun: dryRun);
  }

  Future<void> unregister(App app, {required bool dryRun}) async {
    logger.info("Unregistering $app from the DAM registry");
    final apps = await getApps();
    apps.removeWhere((other) => other.name == app.name);
    await _save(apps, dryRun: dryRun);
  }
}

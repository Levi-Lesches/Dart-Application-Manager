import "dart:io";

import "package:dam/data.dart";
import "package:dam/utils.dart";

abstract class AppService<T extends BaseConfig> {
  static Directory root = Directory(LinuxUtils.home / ".dam");
  T? getConfig(AppConfig config);
  String generate(App app, T config);
  Future<bool> isInstalled(App app);
  Future<void> install(App app, T config, {required bool dryRun});
  Future<void> uninstall(App app, {required bool dryRun});
}

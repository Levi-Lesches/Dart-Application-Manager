import "dart:io";
import "package:yaml/yaml.dart";

import "package:dam/data.dart";
import "package:dam/utils.dart";

class ConfigService {
  Future<AppConfig> readConfig([Directory? dir]) async {
    dir ??= Directory.current;
    final configFile = File(dir / "dam.yaml");
    logger.debug("Reading config file from ${configFile.absolutePath}");
    if (!configFile.existsSync()) {
      throw DamError("No dam.yaml file found in the current directory");
    }
    final contents = await configFile.readAsString();
    logger.logFileContent(contents);
    final yaml = (loadYaml(contents) as YamlMap).toMap();
    return AppConfig.fromJson(dir, yaml);
  }

  Future<AppConfig> getConfigForApp(App app) {
    logger.debug("Finding config for $app");
    return readConfig(app.dir);
  }
}

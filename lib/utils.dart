import "dart:io";

import "package:logger/logger.dart";
import "package:yaml/yaml.dart";
import "package:path/path.dart" as p;

abstract class BaseConfig { }
typedef Json = Map<String, dynamic>;

final logger = Logger(
  filter: ProductionFilter(),
  printer: SimplePrinter(),
);

extension LoggerUtils on Logger {
  void error(String message) => e(message);
  void info(String message) => i(message);
  void debug(String message) => d(message);
  void trace(String message) => t(message);

  void success(String message) => info("✅ $message");
  void failure(String message) => error("❌ $message");

  void logFileContent(String contents) {
    trace("========== Contents of file ==========\n$contents");
    trace("==========   End of file    ==========");
  }

  Future<void> runProcess(
    String name,
    List<String> args, {
    required bool dryRun,
    Directory? dir,
  }) async {
    if (dir == null) {
      debug("Running: `$name ${args.join(' ')}`");
    } else {
      debug("Running: `$name ${args.join(' ')}` in ${dir.absolutePath}");
    }
    if (!dryRun) {
      final result = await Process.run(name, args, workingDirectory: dir?.absolutePath);
      trace("Process output: ");
      trace("- Exit code: ${result.exitCode}");
      trace("- Error output: ${result.stderr}");
      trace("- Standard output: ${result.stdout}");
    }
  }
}

class LinuxUtils {
  static Directory get home => Directory(Platform.environment["HOME"] ?? Directory.current.absolutePath);
  static String get user => Platform.environment["USER"] ?? "user";
}

extension DirectoryUtils on Directory {
  String operator /(String other) => p.normalize("$absolutePath/$other");
}

extension FileDirUtils on FileSystemEntity {
  String get absolutePath => p.normalize(p.absolute(absolute.path));
}

extension JsonUtils on Json {
  T? maybe<T, V>(String key, T Function(V) transform) {
    final value = this[key];
    if (value == null) return null;
    return transform(value);
  }
}

extension YamlMapConverter on YamlMap {
  dynamic _convertNode(dynamic v) {
    if (v is YamlMap) {
      return v.toMap();
    }
    else if (v is YamlList) {
      final list = <dynamic>[];
      for (final e in v) {
        list.add(_convertNode(e));
      }
      return list;
    }
    else {
      return v;
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    nodes.forEach((k, v) {
      final key = (k as YamlScalar).value.toString();
      map[key] = _convertNode(v.value);
    });
    return map;
  }
}

extension FileUtils on File {
  // isInstalled = exists && written by DAM
  // safeToWrite = !exists || written by DAM
  Future<bool> wasGeneratedByDam(String header) async {
    final contents = await readAsString();
    return contents.startsWith(header);
  }

  Future<bool> isInstalledByDam(String header) async =>
    existsSync() && (await wasGeneratedByDam(header));

  Future<bool> isSafeToWrite(String header) async =>
    !existsSync() || (await wasGeneratedByDam(header));

  Future<String> readOrEmpty() async => existsSync()
    ? (await readAsString()) : "";
}

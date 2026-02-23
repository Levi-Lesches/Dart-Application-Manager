import "dart:io";

import "package:version/version.dart";
import "package:dam/utils.dart";

class App {
  final Version version;
  final String name;
  final Directory dir;

  App({
    required this.dir,
    required this.name,
    required this.version,
  });

  App.fromRegistry(Json json) :
    name = json["name"],
    dir = Directory(json["dir"]),
    version = Version.parse(json["version"]);

  App.fromConfig(this.dir, Json json) :
    name = json["name"],
    version = Version.parse(json["version"]);

  Json toJson() => {
    "name": name,
    "dir": dir.absolute.path,
    "version": version.toString(),
  };

  File get configFile => File(dir / "dam.yaml");

  @override
  String toString() => name;
}

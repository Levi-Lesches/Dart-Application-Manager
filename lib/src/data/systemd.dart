import 'package:dam/utils.dart';

class SystemdConfig {
  final String compileCommand;
  final String executableCommand;

  SystemdConfig({
    required this.compileCommand,
    required this.executableCommand,
  });

  SystemdConfig.fromJson(Json json) :
    compileCommand = json["compile"],
    executableCommand = json["executable"];
}

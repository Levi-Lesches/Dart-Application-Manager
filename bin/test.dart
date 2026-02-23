import "package:dam/commands.dart";
import "package:logger/logger.dart";

void main() async {
  Logger.level = .trace;
  await uninstall(null, dryRun: true);
}

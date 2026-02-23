import "package:dam/utils.dart";

class CronConfig extends BaseConfig {
  final String interval;
  final String executable;

  CronConfig({
    required this.interval,
    required this.executable,
  });

  CronConfig.fromJson(Json json) :
    interval = json["interval"],
    executable = json["executable"];
}

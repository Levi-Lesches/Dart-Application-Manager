import 'dart:io';

import 'package:dam/data.dart';
import 'package:dam/services.dart';
import 'package:version/version.dart';

void main() async {
  final app = App(dir: Directory.current, name: "mdeal", version: Version(1, 0, 0));
  // final wconfig = WebServerConfig(
  //   blockCrawlers: true,
  //   domain: "deal.forgot-semicolon.com",
  //   fileServer: FileServerConfig(path: "build/web"),
  //   reverseProxy: ReverseProxyConfig(port: 5050, urlPrefix: "/socket/*"),
  // );
  final cconfig = CronConfig(executable: "bin/email.dart", interval: "* * * * *");
  final service = CronService();
  print(service.generate(app, cconfig));
  // await service.install(app, wconfig);
}

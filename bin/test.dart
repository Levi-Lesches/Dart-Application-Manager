import 'dart:io';

import 'package:dam/data.dart';
import 'package:dam/src/services/caddy.dart';
import 'package:version/version.dart';

void main() async {
  final app = App(dir: Directory.current, name: "mdeal", version: Version(1, 0, 0));
  final wconfig = WebServerConfig(
    blockCrawlers: true,
    domain: "deal.forgot-semicolon.com",
    fileServer: FileServerConfig(path: "build/web"),
    reverseProxy: ReverseProxyConfig(port: 5050, urlPrefix: "/socket/*"),
  );
  final service = CaddyService();
  print(service.generate(app, wconfig));
  await service.install(app, wconfig);
}

import 'package:dam/utils.dart';

class FileServerConfig {
  final String path;

  FileServerConfig({
    required this.path,
  });

  FileServerConfig.fromJson(Json json) :
    path = json["path"];
}

class ReverseProxyConfig {
  final int port;
  final String? urlPrefix;

  ReverseProxyConfig({
    required this.port,
    required this.urlPrefix,
  });

  ReverseProxyConfig.fromJson(Json json) :
    port = json["port"],
    urlPrefix = json["url-prefix"];
}

class WebServerConfig {
  final String domain;
  final bool blockCrawlers;

  FileServerConfig? fileServer;
  ReverseProxyConfig? reverseProxy;

  WebServerConfig({
    required this.domain,
    required this.blockCrawlers,
    this.fileServer,
    this.reverseProxy,
  });

  WebServerConfig.fromJson(Json json) :
    domain = json["domain"],
    blockCrawlers = json["block-crawlers"],
    fileServer = json.maybe("file-server", FileServerConfig.fromJson),
    reverseProxy = json.maybe("reverse-proxy", ReverseProxyConfig.fromJson);
}

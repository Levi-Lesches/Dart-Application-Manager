class FileServerConfig {
  final String path;

  FileServerConfig({
    required this.path,
  });
}

class ReverseProxyConfig {
  final int port;
  final String? urlPrefix;

  ReverseProxyConfig({
    required this.port,
    required this.urlPrefix,
  });
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
}

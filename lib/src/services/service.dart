import 'dart:io';

import 'package:dam/data.dart';
import 'package:dam/utils.dart';

abstract class AppService<T> {
  static Directory root = Directory(DirectoryUtils.home / ".dam");
  String generate(App app, T config);
  Future<bool> isInstalled(App app);
  Future<void> install(App app, T config);
  Future<void> uninstall(App app);
}

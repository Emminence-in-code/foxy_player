import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Config {
  static Config? _configInstance;
  Directory? storageDir;
  Directory? cacheDir;
  static String saveDataFileName = 'tokez';
  static String saveDataExtension = '.txt';

  static Future<Config> getInstance() async {
    if (_configInstance != null) {
      return _configInstance!;
    }
    _configInstance = Config();
    _configInstance!.storageDir = await getApplicationDocumentsDirectory();
    _configInstance!.cacheDir = await getExternalStorageDirectory();
    return _configInstance!;
  }
}

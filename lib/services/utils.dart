import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void writeJsonToFile({required String path, required Map data}) {
  print('saved');
  final String serializedData = json.encode(data);
  final File file = File(path);
  file.createSync(recursive: true);
  file.writeAsStringSync(serializedData);
}

Map readFileAsJson({required String path}) {
  Map result = {};
  try {
    final File file = File(path);
    if (file.existsSync()) {
      String data = file.readAsStringSync();
      final Map jsondata = json.decode(data);
      return jsondata;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return result;
}

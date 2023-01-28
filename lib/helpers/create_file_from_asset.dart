import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<File> createFileFromAsset(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final bytes = data.buffer.asUint8List();
  final file = File(assetPath);
  await file.writeAsBytes(bytes);
  return file;
}

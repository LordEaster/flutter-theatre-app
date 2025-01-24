import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> loadJsonData(String path) async {
  final String jsonString = await rootBundle.loadString(path);
  return json.decode(jsonString) as List<dynamic>;
}
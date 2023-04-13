import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AllergenCache {
  static final AllergenCache instance = AllergenCache._internal();

  String fileName = "allergen.txt";

  factory AllergenCache() {
    return instance;
  }

  Future<void> _init() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/$fileName');

    if (await file.exists()) {
      final content = await file.readAsString();
      Map<String, dynamic> jsonMap = jsonDecode(content);

    } else {

    }
  }

  AllergenCache._internal() {
    _init();
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:allergy_check/dto/user_allergen.dart';
import 'package:path_provider/path_provider.dart';

class AllergenCache {
  static final AllergenCache instance = AllergenCache._internal();

  String fileName = "allergen.txt";
  List<UserAllergen> lst = [];
  Map<String, UserAllergen> map = {};

  factory AllergenCache() {
    return instance;
  }

  Future<void> _init() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/$fileName');

    if (await file.exists()) {
      final content = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(content);
      for (var item in jsonList) {
        UserAllergen userAllergen = UserAllergen(item['name'], item['allergyLevel']);
        lst.add(userAllergen);
        map.putIfAbsent(userAllergen.name, () => userAllergen);
      }
    }
  }

  AllergenCache._internal() {
    _init();
  }

  void upsert(UserAllergen userAllergen) async {
    if (map.containsKey(userAllergen.name)) {
      map[userAllergen.name]?.allergyLevel = userAllergen.allergyLevel;
    } else {
      lst.add(userAllergen);
      map.putIfAbsent(userAllergen.name, () => userAllergen);
    }

    _write();
  }

  Future<void> _write() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(jsonEncode(lst));
  }
}
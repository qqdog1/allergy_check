import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../dto/user_settings.dart';

class UserSettingsCache {
  static final UserSettingsCache instance = UserSettingsCache._internal();
  UserSettings userSettings = UserSettings(false, false, false);
  String fileName = 'settings.txt';

  factory UserSettingsCache() {
    return instance;
  }

  Future<void> _init() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/$fileName');

    if (await file.exists()) {
      final content = await file.readAsString();
      Map<String, dynamic> jsonMap = jsonDecode(content);
      userSettings = UserSettings(jsonMap['isSettingsPage'] ?? false, jsonMap['isFoodSearchPage'] ?? false, jsonMap['isFilterPage'] ?? false);
    } else {
      _write();
    }
  }

  UserSettingsCache._internal() {
    _init();
  }

  void setSettingsPage(bool value) {
    userSettings.isSettingsPage = value;
    _write();
  }

  void setFoodSearchPage(bool value) {
    userSettings.isFoodSearchPage = value;
    _write();
  }

  void setFilterPage(bool value) {
    userSettings.isFilterPage = value;
    _write();
  }

  Future<void> _write() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(userSettings.toString());
  }
}
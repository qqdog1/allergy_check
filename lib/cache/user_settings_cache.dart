import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../dto/user_settings.dart';

class UserSettingsCache {
  static final UserSettingsCache instance = UserSettingsCache._internal();
  late UserSettings userSettings;

  factory UserSettingsCache() {
    instance._init();
    return instance;
  }

  Future<void> _init() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/settings.txt');
    if (await file.exists()) {
      final content = await file.readAsString();
      Map<String, dynamic> jsonMap = jsonDecode(content);
      userSettings = UserSettings(jsonMap['isConfigured'] ?? false, jsonMap['isSettingsPage'] ?? false, jsonMap['isFoodSearchPage'] ?? false, jsonMap['isFilterPage'] ?? false);
    } else {
      userSettings = UserSettings(false, false, false, false);
      await file.writeAsString(userSettings.toString());
    }
  }

  UserSettingsCache._internal();

  void setConfigured(bool value) {
    userSettings.isConfigured = value;
    _write();
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
    final file = File('${directory.path}/settings.txt');
    await file.writeAsString(userSettings.toString());
  }
}
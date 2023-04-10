import 'dart:convert';

class UserSettings {
  // 使用者是否已經設定過過敏原
  final bool isConfigured;
  // 使用者是否已經開過設定畫面顯示過popup
  final bool isSettingsPage;
  // 使用者是否已經開過可能過敏原畫面顯示過popup
  final bool isFoodSearchPage;
  // 使用者是否已經開過搜尋過敏原畫面顯示過popup
  final bool isFilterPage;

  UserSettings(this.isConfigured, this.isSettingsPage, this.isFoodSearchPage, this.isFilterPage);

  Map<String, dynamic> toJson() {
    return {
      'isConfigured': isConfigured,
      'isSettingsPage': isSettingsPage,
      'isFoodSearchPage': isFoodSearchPage,
      'isFilterPage': isFilterPage,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
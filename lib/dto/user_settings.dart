import 'dart:convert';

class UserSettings {
  // 使用者是否已經設定過過敏原
  // 使用者是否已經開過設定畫面顯示過popup
  bool isSettingsPage;
  // 使用者是否已經開過可能過敏原畫面顯示過popup
  bool isFoodSearchPage;
  // 使用者是否已經開過搜尋過敏原畫面顯示過popup
  bool isFilterPage;

  UserSettings(this.isSettingsPage, this.isFoodSearchPage, this.isFilterPage);

  Map<String, dynamic> toJson() {
    return {
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
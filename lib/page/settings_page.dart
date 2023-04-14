import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../cache/user_settings_cache.dart';
import '../dto/user_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class Allergen {
  final String name;
  final String severity;

  const Allergen(this.name, this.severity);
}

class _SettingsPage extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  UserSettingsCache userSettingsCache = UserSettingsCache.instance;
  bool _showPlus = true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      initUserSettings();
    });
  }

  Future<void> initUserSettings() async {
    UserSettings userSettings = userSettingsCache.userSettings;

    if (!userSettings.isSettingsPage) {
      userSettingsCache.setSettingsPage(true);
      showPopup();
    }
  }

  String searchQuery = '';

  final List<Allergen> allergens = [
    Allergen('花生', '嚴重'),
    Allergen('葡萄', '輕微'),
  ];

  List<Allergen> get filteredAllergens {
    return allergens.where((allergen) {
      return allergen.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定已知過敏原'),
        actions: [
          IconButton(
            onPressed: () {
              showPopup();
            },
            icon: const Icon(Icons.question_mark_sharp),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '搜尋過敏原',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // 執行查詢
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 20.0, // Adjust the values as per your requirements
            right: 20.0,
            child: Visibility(
              visible: !_showPlus,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showPlus = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('套用模板'),
              ),
            ),
          ),
          Positioned(
            bottom: 70.0, // Adjust the values as per your requirements
            right: 20.0,
            child: Visibility(
              visible: !_showPlus,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showPlus = true;
                  });
                  // 如果有資料跳confirm
                  // 沒資料當他沒按
                  showDeleteConfirm();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('清除全部'),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0, // Adjust the values as per your requirements
            right: 20.0,
            child: Visibility(
              visible: _showPlus,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _showPlus = false;
                  });
                },
                child: const Icon(Icons.menu),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showPopup() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('這裡可以設定已知過敏原，\n'
            '可使用套用模板，\n'
            '一次設定APP內建200多項過敏原，\n'
            '或自行逐一新增過敏原。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('確定'),
          ),
        ],
      ),
    );
  }

  Future<void> showDeleteConfirm() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('確定要刪除所有資料??'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('確定'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // 設置文字顏色
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
}

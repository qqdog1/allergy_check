import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../cache/user_settings_cache.dart';
import '../dto/user_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
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
      ),
      body: Stack(
        children: [
          // Add your main content widgets here
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
                  child: const Text('新增一個過敏原'),
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
              bottom: 120.0, // Adjust the values as per your requirements
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
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
}

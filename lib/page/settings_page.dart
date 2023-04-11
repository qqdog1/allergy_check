import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../cache/user_settings_cache.dart';
import '../dto/user_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> with SingleTickerProviderStateMixin {
  UserSettingsCache userSettingsCache = UserSettingsCache.instance;

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
            child: FloatingActionButton(
              onPressed: () {
                // Handle the button press event here
              },
              child: const Icon(Icons.add),
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
            '複雜設定:\n'
            '一次設定APP內建200多項過敏原\n'
            '簡易設定:\n'
            '自行逐一新增過敏原'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('確定'),
          ),
        ],
      ),
    );
  }
}

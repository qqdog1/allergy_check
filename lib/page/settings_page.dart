import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  bool isSet = false;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSet = prefs.getBool('isSet') ?? false;
      if (!isSet) {
        showPopup(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定已知過敏原'),
        actions: [
          IconButton(
            onPressed: () {
              showPopup(context);
            },
            icon: const Icon(Icons.question_mark_sharp),
          ),
        ],
      ),
    );
  }

  Future<void> showPopup(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('這裡可以設定已知過敏原，\n'
            '複雜設定:\n'
            '一次帶入APP預設200多項過敏原\n'
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

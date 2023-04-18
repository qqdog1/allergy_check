import 'package:allergy_check/dto/user_allergen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../cache/allergen_cache.dart';
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
  AllergenCache allergenCache = AllergenCache.instance;
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
      showQuestionPopup();
    }
  }

  final TextEditingController _textEditingController = TextEditingController();

  String searchQuery = '';
  String dropdownValue = '輕微';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定已知過敏原'),
        actions: [
          IconButton(
            onPressed: () {
              showQuestionPopup();
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
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: '搜尋或新增過敏原',
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['輕微', '中等', '嚴重', '危險']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    onPressed: () {
                      // 執行查詢
                      setState(() {
                        addNewAllergen();
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            separatorBuilder: (context, index) => const Divider(thickness: 2),
            itemCount: allergenCache.lst.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(allergenCache.lst[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: Text(allergenCache.lst[index].allergyLevel)
                      ),
                    IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {
                      // delete
                      setState(() {
                        allergenCache.delete(allergenCache.lst[index]);
                      });
                    }),
                  ],
                ),
              );
            },
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

  Future<void> showQuestionPopup() {
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

  Future<void> addNewAllergen() async {
    UserAllergen userAllergen =
        UserAllergen(_textEditingController.text, dropdownValue);
    AllergenCache.instance.upsert(userAllergen);
  }
}

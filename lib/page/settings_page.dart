import 'package:allergy_check/dto/user_allergen.dart';
import 'package:allergy_check/page/template_page.dart';
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
      _initUserSettings();
    });
    lstShowingAllergen = AllergenCache.instance.lst;
  }

  Future<void> _initUserSettings() async {
    UserSettings userSettings = userSettingsCache.userSettings;

    if (!userSettings.isSettingsPage) {
      userSettingsCache.setSettingsPage(true);
      // _showQuestionPopup();
    }
  }

  final TextEditingController _textEditingController = TextEditingController();

  List<UserAllergen> lstShowingAllergen = [];
  String _query = '';
  String dropdownValue = '輕微';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定已知過敏原'),
        actions: [
          IconButton(
            onPressed: () {
              _showQuestionPopup();
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
                      decoration: InputDecoration(
                        hintText: '搜尋或新增過敏原',
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _textEditingController.text = '';
                                _query = '';
                                _filterList();
                              });
                            }),
                      ),
                      controller: _textEditingController,
                      onChanged: (value) {
                        _query = value;
                        setState(() {
                          _filterList();
                        });
                      },
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
                      setState(() {
                        _addNewAllergen();
                        _textEditingController.text = '';
                        _query = '';
                        _filterList();
                      });
                    },
                    icon: const Icon(Icons.add),
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
            itemCount: lstShowingAllergen.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: lstShowingAllergen[index].allergyLevel == '輕微'
                    ? Colors.lightGreen
                    : lstShowingAllergen[index].allergyLevel == '中等'
                        ? Colors.yellow
                        : lstShowingAllergen[index].allergyLevel == '嚴重'
                            ? Colors.orange
                            : lstShowingAllergen[index].allergyLevel == '危險'
                                ? Colors.red
                                : Colors.white,
                child: ListTile(
                  title: Text(lstShowingAllergen[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 50.0,
                          child: Text(lstShowingAllergen[index].allergyLevel)),
                      IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            // delete
                            setState(() {
                              allergenCache.delete(lstShowingAllergen[index]);
                              _filterList();
                            });
                          }),
                    ],
                  ),
                ),
              );
            },
          ),
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
                  _showTemplateNotice();
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
                  _showDeleteConfirm();
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

  Future<void> _showQuestionPopup() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('這裡可以設定已知過敏原，\n'
            '可使用套用模板，\n'
            '一次設定APP內建241項過敏原，\n'
            '或自行逐一新增過敏原。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('確定'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirm() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('確定要刪除所有資料??'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                allergenCache.clearAll();
                _filterList();
              });
            },
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

  Future<void> _showTemplateNotice() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('一次設定241項過敏原\n'
            '這將會花你一些時間\n'
            '沒全部設定完不會儲存'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TemplatePage()),
                );
              });
            },
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

  Future<void> _addNewAllergen() async {
    UserAllergen userAllergen =
        UserAllergen(_textEditingController.text, dropdownValue);
    AllergenCache.instance.upsert(userAllergen);
  }

  Future<void> _filterList() async {
    lstShowingAllergen = [];
    for (UserAllergen userAllergen in AllergenCache.instance.lst) {
      if (userAllergen.name.contains(_query)) {
        lstShowingAllergen.add(userAllergen);
      }
    }
  }
}

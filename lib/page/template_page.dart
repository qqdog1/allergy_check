import 'package:allergy_check/cache/allergen_cache.dart';
import 'package:allergy_check/const/allergen.dart';
import 'package:allergy_check/page/settings_page.dart';
import 'package:allergy_check/page/tab_page.dart';
import 'package:flutter/material.dart';

import '../dto/user_allergen.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  AllergenCache allergenCache = AllergenCache.instance;
  Allergen allergen = Allergen();
  int _totalPage = 0;
  int _currentPage = 1;
  List<UserAllergen> _lst = [];

  @override
  void initState() {
    super.initState();
    _totalPage = allergen.lst.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _showLeaveNotice();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Text(
              allergen.lst[_currentPage-1],
              style: const TextStyle(fontSize: 48),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("輕微", Colors.lightGreen),
                _buildButton("中等", Colors.yellow),
                _buildButton("嚴重", Colors.orange),
                _buildButton("危險", Colors.red),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "$_currentPage / $_totalPage",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        UserAllergen userAllergen = UserAllergen(allergen.lst[_currentPage-1], label);
        _lst.add(userAllergen);
        if (_currentPage == allergen.lst.length) {
          allergenCache.upsertAll(_lst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TabPage(index: 2,)));
        } else {
          setState(() {
            _currentPage++;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      ),
      child: Text(label),
    );
  }

  Future<void> _showLeaveNotice() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('現在中斷設定\n'
            '所有內容將不會被儲存'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
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
}

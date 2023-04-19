import 'package:allergy_check/dto/user_settings.dart';
import 'package:allergy_check/page/settings_page.dart';
import 'package:flutter/material.dart';

import '../cache/user_settings_cache.dart';
import 'diary_page.dart';
import 'food_search_page.dart';

class TabPage extends StatefulWidget {
  int index;
  TabPage({super.key, required this.index});
  TabPage.someOtherConstructor({super.key}) : index = 0;

  @override
  _TabPage createState() => _TabPage(index);
}

class _TabPage extends State<TabPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  _TabPage(this._currentIndex);

  @override
  void initState() {
    super.initState();
    initUserSettings();
  }

  Future<void> initUserSettings() async {
    WidgetsFlutterBinding.ensureInitialized();
    UserSettings userSettings = UserSettingsCache.instance.userSettings;
  }

  final List<Widget> _pages = [
    const DiaryPage(),
    const FoodSearchPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.edit), label: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

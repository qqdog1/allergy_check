import 'package:allergy_check/page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filter_page.dart';
import 'food_search_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  _TabPage createState() => _TabPage();
}

class _TabPage extends State<TabPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool isConfigured = false;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isConfigured = prefs.getBool('isConfigured') ?? false;
      if (!isConfigured) {
        _currentIndex = 2;
      }
    });
  }

  final List<Widget> _pages = [
    const FilterPage(),
    const FoodSearchPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
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

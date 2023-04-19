import 'dart:async';
import 'package:allergy_check/cache/allergen_cache.dart';
import 'package:allergy_check/cache/user_settings_cache.dart';
import 'package:allergy_check/page/tab_page.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  late Timer _timer;
  bool _canNavigate = false;

  @override
  void initState() {
    super.initState();
    UserSettingsCache.instance;
    AllergenCache.instance;
    // 启动一个定时器，延迟5秒后自动跳转到下一页
    _timer = Timer(const Duration(seconds: 1), () {
      _canNavigate = true;
      // Navigator.of(context).pushReplacement(
      // MaterialPageRoute(builder: (context) => HomePage()),
      // );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 在页面销毁时取消定时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_canNavigate) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TabPage(index: 0,)));
        }
      },
      behavior: HitTestBehavior.opaque,
      child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)), // 延迟1秒显示
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 显示您的 Logo 或其他欢迎界面
            return Center(
              child: Image.asset('assets/images/logo.png'),
            );
          } else {
            // 延迟结束后，开始显示页面内容
            return TabPage(index: 0,);
          }
        },
      ),
    );
  }
}
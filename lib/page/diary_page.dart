import 'package:flutter/material.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('過敏人日誌'),
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
        content: const Text('希望會是一個方便好用的功能'),
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

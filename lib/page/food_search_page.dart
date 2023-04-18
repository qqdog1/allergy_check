import 'package:flutter/material.dart';

class FoodSearchPage extends StatelessWidget {
  const FoodSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('菜單過敏原查詢'),
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
        content: const Text('敬請期待'),
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

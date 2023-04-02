import 'package:flutter/material.dart';

import 'logo_page.dart';

class AllergyCheck extends StatelessWidget {
  const AllergyCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '人生好難',
      home: LogoPage(),
    );
  }
}
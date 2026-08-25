import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PersonalSiteApp());
}

class PersonalSiteApp extends StatelessWidget {
  const PersonalSiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parsa Shahidi — Robotics',
      debugShowCheckedModeBanner: false,
      theme: buildSiteTheme(),
      home: const HomePage(),
    );
  }
}

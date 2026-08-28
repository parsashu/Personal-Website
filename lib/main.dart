import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Keep font fetching on, but never let a font failure blank the app.
  GoogleFonts.config.allowRuntimeFetching = true;

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
  };
  ErrorWidget.builder = (details) {
    return Material(
      color: const Color(0xFFF4F6F8),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'UI error: ${details.exceptionAsString()}',
            style: const TextStyle(color: Color(0xFF15202B)),
          ),
        ),
      ),
    );
  };

  runApp(const PersonalSiteApp());
}

class PersonalSiteApp extends StatelessWidget {
  const PersonalSiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parsa Shahidi',
      debugShowCheckedModeBanner: false,
      theme: buildSiteTheme(),
      home: const HomePage(),
    );
  }
}

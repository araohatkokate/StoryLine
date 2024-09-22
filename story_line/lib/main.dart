import 'package:flutter/material.dart';
import 'package:story_line/core/theme/theme.dart';
import 'package:story_line/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story Line',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}



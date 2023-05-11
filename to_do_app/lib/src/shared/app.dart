import 'package:flutter/material.dart';
import 'package:to_do_app/src/pages/home_page.dart';
import 'package:to_do_app/src/shared/theme/color_schemes.g.dart';
import 'package:to_do_app/src/shared/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do app',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

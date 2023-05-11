import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/pages/home_page.dart';
import 'package:to_do_app/src/shared/services/theme_services.dart';
import 'package:to_do_app/src/shared/theme/color_schemes.g.dart';
import 'package:to_do_app/src/shared/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To do app',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_app/src/shared/theme/color_schemes.g.dart';

class Themes {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
  );
}

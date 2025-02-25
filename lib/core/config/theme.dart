import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../local/hive_constants.dart';

class AppConstants {
  static const String appName = "Dukaandar";

  static const Color primaryColor = const Color.fromRGBO(26, 188, 156, 70);
  static const Color esportsBackgroundColor =
      const Color.fromRGBO(28, 33, 32, 40);
  static const Color sportsBackgroundColor =
      const Color.fromRGBO(239, 245, 241, 40);
  static const Color disabledColor = const Color.fromRGBO(19, 146, 127, 0.3);
}

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.primaryColor),
  fontFamily: 'Billions',
  useMaterial3: true,
);

Box authBox = Hive.box(HiveConstantBox.authBox);

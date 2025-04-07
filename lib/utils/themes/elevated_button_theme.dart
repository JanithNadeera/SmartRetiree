import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/themes/app_theme.dart';

final elevatedButtonLightTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    minimumSize: const Size(double.maxFinite, 50),
  ),
);

final elevatedButtonDarkTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    minimumSize: const Size(double.maxFinite, 50),
  ),
);

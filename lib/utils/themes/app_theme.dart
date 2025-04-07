import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_retiree/utils/themes/elevated_button_theme.dart';
import 'package:smart_retiree/utils/themes/icon_theme.dart';
import 'package:smart_retiree/utils/themes/text_field_theme.dart';
import 'package:smart_retiree/utils/themes/text_theme.dart';

/// Light Color Scheme
final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFFEC2824),
  onPrimary: const Color(0xFFFFFFFF),
  primaryContainer: Colors.grey.shade100,
  onPrimaryContainer: const Color(0xFF1A1A1A),
  onSecondaryContainer: const Color(0xFF29282E),
  inversePrimary: const Color(0xFFFFB4AA),
  secondary: const Color(0xFF775652), // A17773 , 8C625D
  onSecondary: const Color(0xFFFFFFFF),
  error: Colors.redAccent,
  onError: const Color(0xFFFFFFFF),
  surface: Colors.grey.shade200,
  onSurface: const Color(0xFF0A090E),
  // Additional light color definitions
  secondaryContainer: Colors.grey.shade200,
  surfaceContainerHighest: const Color(0xFF534341),
);

/// Dark Color Scheme
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFEC2824),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF1A1A1A),
  onPrimaryContainer: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF29282E),
  inversePrimary: Color(0xFFB85C54), // A64D48
  secondary: Color(0xFFE7BDB7), // D9A798 C89184
  onSecondary: Color(0xFF5A3B37),
  error: Colors.redAccent,
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFF0A090E),
  onSurface: Color(0xFFFAFAFA),
  // Additional dark color definitions
  onSecondaryContainer: Color(0xFFFFDAD5),
  surfaceContainerHighest: Color(0xFFD8C2BF),
);

/// Light Theme Data
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: lightColorScheme.onSurface),
    titleTextStyle: TextStyle(
      color: lightColorScheme.onSurface,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: lightColorScheme.surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: lightColorScheme.primaryContainer,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: Color.fromRGBO(
      lightColorScheme.onSurface.r.toInt(),
      lightColorScheme.onSurface.g.toInt(),
      lightColorScheme.onSurface.b.toInt(),
      0.12,
    ),
    thickness: 1,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightColorScheme.primaryContainer,
    selectedItemColor: lightColorScheme.primary,
    unselectedItemColor: Color.fromRGBO(
      lightColorScheme.onSurface.r.toInt(),
      lightColorScheme.onSurface.g.toInt(),
      lightColorScheme.onSurface.b.toInt(),
      0.6,
    ),
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ),

  // Dialog Theme
  dialogTheme: DialogTheme(
    backgroundColor: lightColorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Existing properties
  textTheme: lightTextTheme,
  inputDecorationTheme: inputDecorationThemeLight,
  iconTheme: iconThemeLight,
  elevatedButtonTheme: elevatedButtonLightTheme,
);

/// Dark Theme Data
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: darkColorScheme.onSurface),
    titleTextStyle: TextStyle(
      color: darkColorScheme.onSurface,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: darkColorScheme.surface,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: darkColorScheme.primaryContainer,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: Color.fromRGBO(
      darkColorScheme.onSurface.r.toInt(),
      darkColorScheme.onSurface.g.toInt(),
      darkColorScheme.onSurface.b.toInt(),
      0.12,
    ),
    thickness: 1,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColorScheme.primaryContainer,
    selectedItemColor: darkColorScheme.primary,
    unselectedItemColor: Color.fromRGBO(
      darkColorScheme.onSurface.r.toInt(),
      darkColorScheme.onSurface.g.toInt(),
      darkColorScheme.onSurface.b.toInt(),
      0.6,
    ),
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
  ),

  // Dialog Theme
  dialogTheme: DialogTheme(
    backgroundColor: darkColorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Existing properties
  textTheme: darkTextTheme,
  inputDecorationTheme: inputDecorationThemeDark,
  iconTheme: iconThemeDark,
  elevatedButtonTheme: elevatedButtonDarkTheme,
);

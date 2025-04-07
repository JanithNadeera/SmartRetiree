import 'package:flutter/material.dart';

final TextTheme lightTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0A090E),
  ), // onSurface
  displayMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0A090E),
  ),
  displaySmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0A090E),
  ),

  headlineLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color(0xFF0A090E),
  ),
  headlineMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFF0A090E),
  ),
  headlineSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF0A090E),
  ),

  titleLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF0A090E),
  ), // Titles
  titleMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF0A090E),
  ),
  titleSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF0A090E),
  ),

  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xFF29282E),
  ), // Secondary text
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFF29282E),
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFF29282E),
  ),

  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFFEC2824),
  ), // Buttons
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(0xFFEC2824),
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Color(0xFFEC2824),
  ),
);

final TextTheme darkTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFFEDEDED), // Light gray for high contrast
  ), // onSurface
  displayMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFFEDEDED),
  ),
  displaySmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFFEDEDED),
  ),

  headlineLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color(0xFFDDDDDD), // Slightly dimmed for softer contrast
  ),
  headlineMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFFDDDDDD),
  ),
  headlineSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFFDDDDDD),
  ),

  titleLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFFC7C7C7), // Medium contrast for subtitles
  ),
  titleMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFFC7C7C7),
  ),
  titleSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFFC7C7C7),
  ),

  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xFFA5A5A5), // Soft gray for secondary text
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFFA5A5A5),
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFFA5A5A5),
  ),

  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFF8A65), // Accent orange for buttons/labels
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFF8A65),
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFF8A65),
  ),
);

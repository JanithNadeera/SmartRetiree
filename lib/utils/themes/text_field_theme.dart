import 'package:flutter/material.dart';

final inputDecorationThemeLight = InputDecorationTheme(
  fillColor: Colors.grey[100],
  filled: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  hintStyle: const TextStyle(color: Colors.black38),
  labelStyle: const TextStyle(color: Colors.black87),
  errorStyle: const TextStyle(color: Color(0xFFE74C3C)),
  prefixIconColor: Color(0xFF595959),
  suffixIconColor: Color(0xFF595959),
  border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black26),
      borderRadius: BorderRadius.circular(8)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black26),
      borderRadius: BorderRadius.circular(8)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black38, width: 1.5),
      borderRadius: BorderRadius.circular(8)),
  errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE74C3C)),
      borderRadius: BorderRadius.circular(8)),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 1.5),
      borderRadius: BorderRadius.circular(8)),
);

final inputDecorationThemeDark = InputDecorationTheme(
  fillColor: const Color(0xFF29282E),
  filled: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  hintStyle: const TextStyle(color: Colors.white),
  labelStyle: const TextStyle(color: Colors.white),
  errorStyle: const TextStyle(color: Color(0xFFE74C3C)),
  prefixIconColor: Color(0xFFB0B0B0),
  suffixIconColor: Color(0xFFB0B0B0),
  border: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF3D3D3D)),
      borderRadius: BorderRadius.circular(8)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF3D3D3D)),
      borderRadius: BorderRadius.circular(8)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF888888), width: 1.5),
      borderRadius: BorderRadius.circular(8)),
  errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE74C3C)),
      borderRadius: BorderRadius.circular(8)),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 1.5),
      borderRadius: BorderRadius.circular(8)),
);

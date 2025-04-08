import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcome to the Support Screen!',
            style: context.displayMedium,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcome to the Forum Screen!',
            style: context.displayMedium,
          ),
        ),
      ),
    );
  }
}

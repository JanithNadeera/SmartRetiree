import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: context.titleLarge,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: context.secondaryContainer,
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to the Home Screen!',
              style: context.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}

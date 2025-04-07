import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int activeIndex = 0;
  final icons = [
    (Icons.home_outlined, Icons.home, "New Order"),
    (Icons.food_bank_outlined, Icons.food_bank, "Order"),
    (Clarity.settings_line, Clarity.settings_solid, "Settings"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [Container(), Container(), Container()][activeIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ).copyWith(top: 8),
          child: GNav(
            gap: 8,
            activeColor: context.primary,
            color: Colors.grey,
            tabs: icons.mapIndexed((index, item) {
              return GButton(
                icon: activeIndex == index ? item.$2 : item.$1,
                text: item.$3,
              );
            }).toList(),
            onTabChange: (index) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

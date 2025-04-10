import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smart_retiree/ui/mp/chat_room/chat_rooms_screen.dart';
import 'package:smart_retiree/ui/mp/home/home_screen.dart';
import 'package:smart_retiree/ui/mp/profile/profile_screen.dart';
import 'package:smart_retiree/ui/mp/support/event_list_screen.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int activeIndex = 0;
  final icons = [
    (MingCute.rss_line, MingCute.rss_fill, "Feed"),
    (MingCute.chat_1_line, MingCute.chat_1_fill, "Connect"),
    (MingCute.hand_heart_line, MingCute.hand_heart_fill, "Events"),
    (MingCute.user_5_line, MingCute.user_5_fill, "Profile"),
  ];

  final screens = [
    const HomeScreen(),
    const ChatRoomsScreen(),
    const EventListScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],
      bottomNavigationBar: SafeArea(
        child: GNav(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          gap: 8,
          activeColor: context.primary,
          color: Colors.grey,
          tabs: icons.mapIndexed((index, item) {
            return GButton(
              icon: activeIndex == index ? item.$2 : item.$1,
              text: item.$3,
              iconSize: 27.5,
            );
          }).toList(),
          onTabChange: (index) {
            setState(() {
              activeIndex = index;
            });
          },
        ),
      ),
    );
  }
}

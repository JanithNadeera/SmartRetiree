import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/ui/mp/chat/chat_screen.dart';
import 'package:smart_retiree/ui/mp/feed/feed_screen.dart';
import 'package:smart_retiree/ui/mp/profile/profile_screen.dart';
import 'package:smart_retiree/ui/mp/events/event_screen.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int activeIndex = 0;
  final icons = [
    (MingCuteIcons.mgc_rss_line, MingCuteIcons.mgc_rss_fill, "Feed"),
    (MingCuteIcons.mgc_chat_1_line, MingCuteIcons.mgc_chat_1_fill, "Connect"),
    (
      MingCuteIcons.mgc_hand_heart_line,
      MingCuteIcons.mgc_hand_heart_fill,
      "Events"
    ),
    (MingCuteIcons.mgc_user_5_line, MingCuteIcons.mgc_user_5_fill, "Profile"),
  ];

  final screens = [
    const FeedScreen(),
    const ChatScreen(),
    const EventScreen(),
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

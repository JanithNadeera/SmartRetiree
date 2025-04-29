import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/ui/mp/chat/chat_screen.dart';
import 'package:smart_retiree/ui/mp/feed/feed_screen.dart';
import 'package:smart_retiree/ui/mp/profile/profile_screen.dart';
import 'package:smart_retiree/ui/mp/events/event_screen.dart';
import 'package:smart_retiree/utils/theme_extension.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _command = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    try {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: $error'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _command = result.recognizedWords;
              debugPrint("Heard: $_command");
            });
            _handleCommand(_command);
          },
        );
      } else {
        debugPrint("The user has denied the use of speech recognition.");
        _speech.stop();
        setState(() => _isListening = false);
      }
    } catch (e) {
      debugPrint("Error initializing speech recognition: $e");
    }
  }

  void _handleCommand(String command) {
    command = command.toLowerCase();
    if (command.contains("feed")) {
      setState(() => activeIndex = 0);
    } else if (command.contains("chat") || command.contains("connect")) {
      setState(() => activeIndex = 1);
    } else if (command.contains("event")) {
      setState(() => activeIndex = 2);
    } else if (command.contains("profile")) {
      setState(() => activeIndex = 3);
    }
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _isListening ? _speech.stop : _startListening,
        child: Icon(_isListening ? Icons.mic_off : Icons.mic),
      ),
      bottomNavigationBar: SafeArea(
        child: GNav(
          selectedIndex: activeIndex,
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

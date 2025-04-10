import 'package:flutter/material.dart';
import 'package:smart_retiree/ui/mp/home/post_view.dart';
import 'package:smart_retiree/ui/mp/home/widgets/home_app_bar.dart';
// import 'package:smart_retiree/utils/firebase_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // FirebaseUtils.clearAllChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: ListView(
          children: const [
            PostView(),
            PostView(),
            PostView(),
          ],
        ),
      ),
    );
  }
}

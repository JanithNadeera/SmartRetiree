import 'package:flutter/material.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/widgets/custom_follow_notification.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/widgets/custom_liked_notification.dart';

class NotitcationTap extends StatelessWidget {
  NotitcationTap({super.key});
  final List newItem = ["liked", "follow"];
  final List todayItem = ["follow", "liked", "liked"];

  final List oldesItem = ["follow", "follow", "liked", "liked"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          'N O T I F I C A T I O N S',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'RobotoMono', // Updated to use RobotoMono font family
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newItem.length,
                itemBuilder: (context, index) {
                  return newItem[index] == "follow"
                      ? const CustomFollowNotifcation()
                      : const CustomLikedNotifcation();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Today",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: todayItem.length,
                itemBuilder: (context, index) {
                  return todayItem[index] == "follow"
                      ? const CustomFollowNotifcation()
                      : const CustomLikedNotifcation();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Oldest",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: oldesItem.length,
                itemBuilder: (context, index) {
                  return oldesItem[index] == "follow"
                      ? const CustomFollowNotifcation()
                      : const CustomLikedNotifcation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

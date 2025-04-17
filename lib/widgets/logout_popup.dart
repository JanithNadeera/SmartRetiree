import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/ui/landing/sign_in_page/sign_in_page.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class LogoutPopup extends ConsumerWidget {
  const LogoutPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .7,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: context.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.red.shade100,
                child: Icon(
                  Icons.logout_rounded,
                  size: 40,
                  color: context.primary,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Logout",
                style: context.headlineMedium,
              ),
              const SizedBox(height: 5),
              Text(
                "Are you sure you want to logout?",
                style: context.bodyMedium,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  ref.read(userProvider.notifier).state = null;
                  CoreUtils.postFrameCall(() => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false));
                },
                child: const Text("Yes, logout"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.secondaryContainer,
                  elevation: 0,
                  foregroundColor: context.onPrimaryContainer,
                  textStyle: context.titleMedium,
                ),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

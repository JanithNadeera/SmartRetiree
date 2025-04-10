import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/providers/app_start_provider.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/shared_widgets/linear_indicator.dart';
import 'package:smart_retiree/ui/landing/sign_in_page/sign_in_page.dart';
import 'package:smart_retiree/ui/mp/navigation/navigation_screen.dart';
import 'package:smart_retiree/utils/core_utils.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStart = ref.watch(appStartProvider);
    appStart.when(
      data: (_) {
        final user = ref.read(userProvider);
        CoreUtils.postFrameCall(() {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  user == null ? const LoginScreen() : const NavigationScreen(),
            ),
            (route) => false,
          );
        });
      },
      error: (error, stackTrace) {
        log(error.toString());
        CoreUtils.showToast(
          type: ToastType.error,
          message: 'Error: $error',
        );
      },
      loading: () {},
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/Cover.png',
              width: 200,
            ),
            const Gap(16),
            const LinearIndicator()
          ],
        ),
      ),
    );
  }
}

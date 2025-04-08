import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retiree/shared_widgets/logout_popup.dart';
import 'package:smart_retiree/utils/core_utils.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              IconButton(
                  onPressed: () => CoreUtils.heroDialog(const LogoutPopup()),
                  icon: const Icon(
                    Icons.logout_rounded,
                    size: 40,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

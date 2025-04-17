import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/widgets/custom_appbar.dart';
import 'package:smart_retiree/widgets/logout_popup.dart';
import 'package:smart_retiree/ui/mp/profile/edit_profile.dart';
import 'package:smart_retiree/ui/mp/profile/widgets/profile_card.dart';
import 'package:smart_retiree/ui/mp/profile/widgets/profile_image.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Profile', withShader: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ProfileImage(
                url: user.profilePhoto,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
              ),
              const Gap(16),
              Text(
                user.fullName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Gap(32),
              ProfileCard(
                title: "First Name",
                subtitle: user.firstName,
                icon: Icons.text_fields_sharp,
              ),
              ProfileCard(
                title: "Last Name",
                subtitle: user.lastName,
                icon: Icons.text_fields_sharp,
              ),
              ProfileCard(
                title: "Email",
                subtitle: user.email,
                icon: Icons.email,
              ),
              ProfileCard(
                title: "Occuption",
                subtitle: user.occupation,
                icon: Icons.work,
              ),
              GestureDetector(
                onTap: () {
                  CoreUtils.heroDialog(const LogoutPopup());
                },
                child: ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: context.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: context.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

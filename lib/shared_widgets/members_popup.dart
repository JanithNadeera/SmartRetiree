import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/shared_widgets/submit_button.dart';
import 'package:smart_retiree/ui/mp/chat_room/widgets/user_avatar.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class MembersPopup extends ConsumerWidget {
  const MembersPopup({
    super.key,
    required this.title,
    required this.users,
  });

  final String title;
  final List<AppUser> users;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .75,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: context.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: context.headlineMedium,
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 0, maxHeight: 300),
              child: Material(
                color: Colors.transparent,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (_, index) {
                    final user = users[index];
                    final isCurrentUser =
                        user.uid == ref.watch(userProvider)!.uid;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      leading: UserAvatar(imageUrl: user.profilePhoto),
                      title: Text(
                        "${user.fullName} ${isCurrentUser ? "(You)" : ""}",
                        style: context.headlineSmall,
                      ),
                      subtitle: Text(
                        user.occupation,
                        style: context.bodyMedium,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            SubmitButton(
              onPressed: () => Navigator.pop(context),
              label: "Close",
            )
          ],
        ),
      ),
    );
  }
}

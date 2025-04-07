import 'package:smart_retiree/utils/user_role_selector.dart';

extension StringExt on String {
  UserRole get role {
    return switch (this) {
      'retiree' => UserRole.retiree,
      'seeker' => UserRole.seeker,
      _ => UserRole.retiree,
    };
  }
}

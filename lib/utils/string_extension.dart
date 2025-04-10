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

extension InitialsExtension on String {
  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) return words.first[0].toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}

import 'package:smart_retiree/utils/user_role_selector.dart';
import 'package:smart_retiree/utils/string_extension.dart' as ext;

class AppUser {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String occupation;
  final UserRole role;

  AppUser({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.occupation,
    required this.role,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) {
    return AppUser(
      uid: uid,
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      occupation: map['occupation'] ?? '',
      role: (map['user_role'])?.role ?? '',
    );
  }
}

import 'package:smart_retiree/utils/user_role_selector.dart';
import 'package:smart_retiree/utils/string_extension.dart';

class AppUser {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String occupation;
  final String? profilePhoto;
  final UserRole role;

  AppUser({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.fullName = '',
    required this.occupation,
    this.profilePhoto,
    required this.role,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) {
    return AppUser(
      uid: uid,
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      fullName: "${map['first_name'] ?? ''} ${map['last_name'] ?? ''}".trim(),
      occupation: map['occupation'] ?? '',
      profilePhoto: map['profile_photo'],
      role: (map['user_role'] as String).role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'occupation': occupation,
      'profile_photo': profilePhoto,
      'user_role': role.name,
    };
  }

  AppUser.empty(String id)
      : email = "test@gmail.com",
        firstName = "Unknown",
        lastName = "User",
        occupation = "",
        profilePhoto = "",
        role = UserRole.retiree,
        uid = id,
        fullName = "Unknown User";
}

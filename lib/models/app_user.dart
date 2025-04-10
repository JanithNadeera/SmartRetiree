// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smart_retiree/utils/string_extension.dart';
import 'package:smart_retiree/utils/user_role_selector.dart';

class AppUser {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String occupation;
  final String profilePhoto;
  final UserRole role;

  AppUser({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.fullName = '',
    required this.occupation,
    required this.profilePhoto,
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
      profilePhoto:
          map['profile_photo'] ?? 'https://www.gravatar.com/avatar/?d=mp',
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
        profilePhoto = "https://www.gravatar.com/avatar/?d=mp",
        role = UserRole.retiree,
        uid = id,
        fullName = "Unknown User";

  AppUser copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? fullName,
    String? occupation,
    String? profilePhoto,
    UserRole? role,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: "$firstName $lastName",
      occupation: occupation ?? this.occupation,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      role: role ?? this.role,
    );
  }
}

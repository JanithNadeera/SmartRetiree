class PostUser {
  final String id;
  final String fullName;
  final String occupation;
  final String profilePhoto;

  PostUser({
    required this.id,
    required this.fullName,
    required this.occupation,
    required this.profilePhoto,
  });

  factory PostUser.fromMap(Map<String, dynamic> map) {
    return PostUser(
      id: map['id'],
      fullName: map['full_name'] ?? '',
      occupation: map['occupation'] ?? '',
      profilePhoto: map['profile_photo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'occupation': occupation,
      'profile_photo': profilePhoto,
    };
  }
}

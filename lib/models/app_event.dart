class AppEvent {
  final String id;
  final String name;
  final String time;
  final String location;
  final String type;
  final String imageUrl;
  final String description;
  final DateTime createdAt;
  final String createdBy;
  final List<String> members;

  AppEvent({
    required this.id,
    required this.name,
    required this.time,
    required this.location,
    required this.type,
    required this.imageUrl,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.members,
  });

  factory AppEvent.fromMap(String uid, Map<String, dynamic> data) {
    return AppEvent(
      id: uid,
      name: data['name'] ?? '',
      time: data['datetime'] ?? '',
      location: data['location'] ?? '',
      type: data['type'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      createdAt: DateTime.parse(data['createdAt']),
      createdBy: data['createdBy'] ?? '',
      members: List<String>.from(data['members'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
      'location': location,
      'type': type,
      'imageUrl': imageUrl,
      'description': description,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'members': members,
    };
  }
}

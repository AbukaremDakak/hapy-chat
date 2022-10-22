class Room {
  final String id;
  final String name;
  final DateTime createdAt;

  Room({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  Room.fromMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.name = map['name'] ?? 'Untitled',
        this.createdAt = DateTime.parse(
          map['created_at'],
        );
}

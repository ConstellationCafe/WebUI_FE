
abstract class Entity {
  final List<Map<String, dynamic>> metadata;

  const Entity({required this.metadata});

  Map<String, dynamic> toJson();
}
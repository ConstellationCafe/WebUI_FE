import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class MenuEntity extends Entity {
  String mnValue;
  String discordId;

  MenuEntity({
    required super.metadata,
    required this.mnValue,
    required this.discordId,
  });

  @override
  Map<String, dynamic> toJson() => {'mnValue': mnValue, 'discordId': discordId};

  @override
  Map<String, dynamic> toDisplayJson() => {
    'mnValue': mnValue,
    'discordId': discordId,
  };

  factory MenuEntity.init(List<Map<String, dynamic>> metadata) {
    return MenuEntity(metadata: metadata, mnValue: '', discordId: '');
  }

  factory MenuEntity.fromJson(
    List<Map<String, dynamic>> metadata,
    Map<String, dynamic> json,
  ) {
    return MenuEntity(
      metadata: metadata,
      mnValue: (json['mnValue'] ?? '').toString(),
      discordId: (json['recommender'] ?? '').toString(),
    );
  }
}

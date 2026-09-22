import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class ContentEntity extends Entity {
  String cnValue;
  String discordId;

  ContentEntity({
    required super.metadata,
    required this.cnValue,
    required this.discordId,
  });

  @override
  Map<String, dynamic> toJson() => {'cnValue': cnValue, 'discordId': discordId};

  @override
  Map<String, dynamic> toDisplayJson() => {
    'cnValue': cnValue,
    'discordId': discordId,
  };

  factory ContentEntity.init(List<Map<String, dynamic>> metadata) {
    return ContentEntity(metadata: metadata, cnValue: '', discordId: '');
  }

  factory ContentEntity.fromJson(
    List<Map<String, dynamic>> metadata,
    Map<String, dynamic> json,
  ) {
    return ContentEntity(
      metadata: metadata,
      cnValue: (json['cnValue'] ?? '').toString(),
      discordId: (json['recommender'] ?? '').toString(),
    );
  }
}

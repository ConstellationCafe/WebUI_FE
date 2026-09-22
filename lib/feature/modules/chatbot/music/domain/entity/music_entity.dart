import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class MusicEntity extends Entity {
  String videoId;
  String discordId;

  MusicEntity({
    required super.metadata,
    required this.videoId,
    required this.discordId,
  });

  @override
  Map<String, dynamic> toJson() => {'videoId': videoId, 'discordId': discordId};

  @override
  Map<String, dynamic> toDisplayJson() => {
    'videoId': videoId,
    'discordId': discordId,
  };

  factory MusicEntity.init(List<Map<String, dynamic>> metadata) {
    return MusicEntity(metadata: metadata, videoId: '', discordId: '');
  }

  factory MusicEntity.fromJson(
    List<Map<String, dynamic>> metadata,
    Map<String, dynamic> json,
  ) {
    return MusicEntity(
      metadata: metadata,
      videoId: (json['videoId'] ?? '').toString(),
      discordId: (json['recommender'] ?? '').toString(),
    );
  }
}

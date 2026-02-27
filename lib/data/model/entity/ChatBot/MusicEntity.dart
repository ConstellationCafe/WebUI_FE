import '../EntityInterface.dart';

class MusicEntity extends Entity {
  String videoId;

  MusicEntity({
    required super.metadata,
    required this.videoId
  });

  @override
  Map<String, dynamic> toJson() => {
    'videoId': videoId
  };

  factory MusicEntity.fromJson(
      List<Map<String, dynamic>> metadata,
      Map<String, dynamic> json) {
    return MusicEntity(
      metadata: metadata,
      videoId: (json['videoId'] ?? '').toString(),
    );
  }
}

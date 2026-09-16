import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class MusicEntity extends Entity {
  String videoId;
  String recommender;
  String recommenderDiscordId;

  MusicEntity({
    required super.metadata,
    required this.videoId,
    required this.recommender,
    required this.recommenderDiscordId,
  });

  @override
  Map<String, dynamic> toJson() => {
    'videoId': videoId,
    'recommender': recommender,
  };

  @override
  Map<String, dynamic> toDisplayJson() => {
    'recommender': recommenderDiscordId,
  };

  factory MusicEntity.init(List<Map<String, dynamic>> metadata) {
    return MusicEntity(
      metadata: metadata,
      videoId: '',
      recommender: '',
      recommenderDiscordId: '',
    );
  }

  factory MusicEntity.fromJson(
      List<Map<String, dynamic>> metadata,
      Map<String, dynamic> json,
      ) {
    return MusicEntity(
      metadata: metadata,
      videoId: (json['videoId'] ?? '').toString(),
      recommender: (json['recommender'] ?? '').toString(),
      recommenderDiscordId:
      (json['recommenderDiscordId'] ?? '').toString(),
    );
  }
}
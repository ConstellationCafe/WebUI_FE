import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class ContentEntity extends Entity {
  String cnValue;
  String recommender;
  String recommenderDiscordId;

  ContentEntity({
    required super.metadata,
    required this.cnValue,
    required this.recommender,
    required this.recommenderDiscordId,
  });

  @override
  Map<String, dynamic> toJson() => {
    'cnValue': cnValue,
    'recommender': recommender,
  };

  @override
  Map<String, dynamic> toDisplayJson() => {
    'recommender': recommenderDiscordId,
  };

  factory ContentEntity.init(List<Map<String, dynamic>> metadata) {
    return ContentEntity(
      metadata: metadata,
      cnValue: '',
      recommender: '',
      recommenderDiscordId: '',
    );
  }

  factory ContentEntity.fromJson(
      List<Map<String, dynamic>> metadata,
      Map<String, dynamic> json,
      ) {
    return ContentEntity(
      metadata: metadata,
      cnValue: (json['cnValue'] ?? '').toString(),
      recommender: (json['recommender'] ?? '').toString(),
      recommenderDiscordId:
      (json['recommenderDiscordId'] ?? '').toString(),
    );
  }
}
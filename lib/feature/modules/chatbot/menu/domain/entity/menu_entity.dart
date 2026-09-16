import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class MenuEntity extends Entity {
  String mnValue;
  String recommender;
  String recommenderDiscordId;

  MenuEntity({
    required super.metadata,
    required this.mnValue,
    required this.recommender,
    required this.recommenderDiscordId,
  });

  @override
  Map<String, dynamic> toJson() => {
    'mnValue': mnValue,
    'recommender': recommender,
  };

  @override
  Map<String, dynamic> toDisplayJson() => {
    'recommender': recommenderDiscordId,
  };

  factory MenuEntity.init(List<Map<String, dynamic>> metadata) {
    return MenuEntity(
      metadata: metadata,
      mnValue: '',
      recommender: '',
      recommenderDiscordId: '',
    );
  }

  factory MenuEntity.fromJson(
      List<Map<String, dynamic>> metadata,
      Map<String, dynamic> json,
      ) {
    return MenuEntity(
      metadata: metadata,
      mnValue: (json['mnValue'] ?? '').toString(),
      recommender: (json['recommender'] ?? '').toString(),
      recommenderDiscordId:
      (json['recommenderDiscordId'] ?? '').toString(),
    );
  }
}
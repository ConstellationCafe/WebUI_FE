import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class ContentEntity extends Entity {
  String cnValue;
  String recommender;

  ContentEntity({
    required super.metadata,
    required this.cnValue,
    required this.recommender
  });

  @override
  Map<String, dynamic> toJson() => {
    'cnValue': cnValue,
    'recommender': recommender
  };

  factory ContentEntity.init(List<Map<String, dynamic>> metadata) {
    return ContentEntity(
      metadata: metadata,
      cnValue: '',
      recommender: ''
    );
  }

  factory ContentEntity.fromJson(
      List<Map<String, dynamic>> metadata,
      Map<String, dynamic> json) {
    return ContentEntity(
      metadata: metadata,
      cnValue: (json['cnValue'] ?? '').toString(),
      recommender: (json['recommender'] ?? '').toString(),
    );
  }
}

import '../../../../../shared/domain/entity/entity_interface.dart';

class ContentEntity extends Entity {
  String cnValue;

  ContentEntity({
    required super.metadata,
    required this.cnValue
  });

  @override
  Map<String, dynamic> toJson() => {
    'cnValue': cnValue
  };

  factory ContentEntity.init(List<Map<String, dynamic>> metadata) {
    return ContentEntity(
      metadata: metadata,
      cnValue: '',
    );
  }

  factory ContentEntity.fromJson(
      List<Map<String, dynamic>> metadata,
      Map<String, dynamic> json) {
    return ContentEntity(
      metadata: metadata,
      cnValue: (json['cnValue'] ?? '').toString(),
    );
  }
}

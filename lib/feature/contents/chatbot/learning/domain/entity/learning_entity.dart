import '../../../../../../shared/domain/entity/entity_interface.dart';

class LearningEntity extends Entity {
  String lnKey;
  String lnValue;

  LearningEntity({
    required super.metadata,
    required this.lnKey,
    required this.lnValue
  });

  @override
  Map<String, dynamic> toJson() => {
    'lnKey': lnKey,
    'lnValue': lnValue
  };

  factory LearningEntity.init(List<Map<String, dynamic>> metadata) {
    return LearningEntity(
      metadata: metadata,
      lnKey: '',
      lnValue: '',
    );
  }

  factory LearningEntity.fromJson(
      List<Map<String, dynamic>> metadata,
      Map<String, dynamic> json) {
    return LearningEntity(
      metadata: metadata,
      lnKey: (json['lnKey'] ?? '').toString(),
      lnValue: (json['lnValue'] ?? '').toString(),
    );
  }
}

import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class LearningEntity extends Entity {
  String lnKey;
  String lnValue;
  String discordId;

  LearningEntity({
    required super.metadata,
    required this.lnKey,
    required this.lnValue,
    required this.discordId,
  });

  factory LearningEntity.init(List<Map<String, dynamic>> metadata) {
    return LearningEntity(
      metadata: metadata,
      lnKey: '',
      lnValue: '',
      discordId: '',
    );
  }

  factory LearningEntity.fromJson(
    List<Map<String, dynamic>> metadata,
    Map<String, dynamic> json,
  ) {
    return LearningEntity(
      metadata: metadata,
      lnKey: (json['lnKey'] ?? '').toString(),
      lnValue: (json['lnValue'] ?? '').toString(),

      // BE teacher에는 Discord ID가 담겨있다.
      discordId: (json['teacher'] ?? '').toString(),
    );
  }

  /// API 기준 JSON
  @override
  Map<String, dynamic> toJson() {
    return {'lnKey': lnKey, 'lnValue': lnValue, 'teacher': discordId};
  }

  /// DBEditor 표시 기준 JSON
  @override
  Map<String, dynamic> toDisplayJson() {
    return {'lnKey': lnKey, 'lnValue': lnValue, 'discordId': discordId};
  }
}

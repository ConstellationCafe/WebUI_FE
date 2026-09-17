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

  factory LearningEntity.init(
      List<Map<String, dynamic>> metadata,
      ) {
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

      // BE: teacher
      // FE: discordId
      discordId: (json['teacher'] ?? '').toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // BE API 전송용
    return {
      'lnKey': lnKey,
      'lnValue': lnValue,
      'teacher': discordId,
    };
  }

  @override
  Map<String, dynamic> toDisplayJson() {
    // DBEditor 표시용
    return {
      'lnKey': lnKey,
      'lnValue': lnValue,
      'discordId': discordId,
    };
  }
}
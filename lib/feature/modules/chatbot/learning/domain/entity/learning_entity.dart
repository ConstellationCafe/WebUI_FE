import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

class LearningEntity extends Entity {
  String lnKey;
  String lnValue;
  String teacher;
  // 화면 표시용 (실제 DB엔 X)
  String teacherDiscordId;

  LearningEntity({
    required super.metadata,
    required this.lnKey,
    required this.lnValue,
    required this.teacher,
    required this.teacherDiscordId,
  });

  @override
  Map<String, dynamic> toJson() => {
    'lnKey': lnKey,
    'lnValue': lnValue,
    'teacher': teacher,
  };

  @override
  Map<String, dynamic> toDisplayJson() => {
    'teacher': teacherDiscordId,
  };

  factory LearningEntity.init(
      List<Map<String, dynamic>> metadata,
      ) {
    return LearningEntity(
      metadata: metadata,
      lnKey: '',
      lnValue: '',
      teacher: '',
      teacherDiscordId: '',
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
      teacher: (json['teacher'] ?? '').toString(),
      teacherDiscordId: (json['teacherDiscordId'] ?? '').toString(),
    );
  }
}
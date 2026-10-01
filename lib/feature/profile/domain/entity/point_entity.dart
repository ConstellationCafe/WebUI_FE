import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

import '../../constants/point_log_columns.dart';

class PointEntity extends Entity {
  String amount;
  String at;
  String description;

  PointEntity({
    required super.metadata,
    required this.amount,
    required this.at,
    required this.description,
  });

  @override
  Map<String, dynamic> toJson() => {
    PointLogColumns.amount: amount,
    PointLogColumns.at: at,
    PointLogColumns.description: description,
  };

  factory PointEntity.init(List<Map<String, dynamic>> metadata) {
    return PointEntity(metadata: metadata, amount: '', at: '', description: '');
  }

  factory PointEntity.fromJson(
    List<Map<String, dynamic>> metadata,
    Map<String, dynamic> json,
  ) {
    return PointEntity(
      metadata: metadata,
      amount: (json['amount'] ?? '').toString(),
      at: (json['at'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
    );
  }
}

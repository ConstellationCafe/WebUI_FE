import '../../../../../shared/domain/entity/entity_interface.dart';

class PointEntity extends Entity {
  String amount;
  String at;
  String description;

  PointEntity({
    required super.metadata,
    required this.amount,
    required this.at,
    required this.description
  });

  @override
  Map<String, dynamic> toJson() => {
    '변동 금액': amount,
    '변동 일자': at,
    '변동 내용': description,
  };

  factory PointEntity.init(List<Map<String, dynamic>> metadata) {
    return PointEntity(
      metadata: metadata,
      amount: '',
      at: '',
      description: '',
    );
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

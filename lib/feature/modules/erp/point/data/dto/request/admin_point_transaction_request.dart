import '../../../domain/type/point_transaction_type.dart';

class AdminPointTransactionRequest {
  final PointTransactionType type;
  final int amount;
  final String description;

  const AdminPointTransactionRequest({
    required this.type,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name.toUpperCase(),
    'amount': amount,
    'description': description.trim(),
  };
}

class AdminPointLogResponse {
  final int amount;
  final DateTime at;
  final String? description;
  final String sourceAt;

  const AdminPointLogResponse({
    required this.amount,
    required this.at,
    required this.description,
    required this.sourceAt,
  });

  factory AdminPointLogResponse.fromJson(Map<String, dynamic> json) {
    final timestamp = json['at'] as String;
    // Membership stores UTC LocalDateTime values without a timezone suffix.
    final hasOffset = RegExp(r'(Z|[+-]\d{2}:\d{2})$').hasMatch(timestamp);
    return AdminPointLogResponse(
      amount: (json['amount'] as num).toInt(),
      at: DateTime.parse(hasOffset ? timestamp : '${timestamp}Z').toUtc(),
      description: json['description'] as String?,
      sourceAt: timestamp,
    );
  }
}

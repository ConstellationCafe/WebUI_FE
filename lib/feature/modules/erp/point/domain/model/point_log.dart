class PointLog {
  final int amount;
  final DateTime at;
  final String description;
  final String? sourceAt;

  const PointLog({
    required this.amount,
    required this.at,
    required this.description,
    this.sourceAt,
  });

  String get referenceAt =>
      sourceAt ?? at.toUtc().toIso8601String().replaceFirst(RegExp(r'Z$'), '');
}

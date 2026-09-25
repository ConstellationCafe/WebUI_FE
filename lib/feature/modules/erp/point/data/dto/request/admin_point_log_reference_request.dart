class AdminPointLogReferenceRequest {
  final int originalAmount;
  final String at;

  const AdminPointLogReferenceRequest({
    required this.originalAmount,
    required this.at,
  });

  Map<String, dynamic> toJson() => {'at': at};
}

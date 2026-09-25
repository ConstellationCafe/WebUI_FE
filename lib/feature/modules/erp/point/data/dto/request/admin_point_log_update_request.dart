class AdminPointLogUpdateRequest {
  final int? amount;
  final String? description;

  const AdminPointLogUpdateRequest({this.amount, this.description});

  Map<String, dynamic> toJson() => {
    if (amount != null) 'amount': amount,
    if (description != null) 'description': description!.trim(),
  };
}

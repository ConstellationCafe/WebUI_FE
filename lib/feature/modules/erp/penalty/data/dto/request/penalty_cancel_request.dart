class PenaltyCancelRequest {
  final String reason;

  const PenaltyCancelRequest({required this.reason});

  Map<String, dynamic> toJson() => {'reason': reason.trim()};
}

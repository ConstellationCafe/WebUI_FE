class StudentStatusSummaryResponse {
  final int totalCount;
  final int enrolledCount;
  final int graduationCount;
  final int expulsionCount;
  final int withdrawalCount;

  const StudentStatusSummaryResponse({
    required this.totalCount,
    required this.enrolledCount,
    required this.graduationCount,
    required this.expulsionCount,
    required this.withdrawalCount,
  });

  factory StudentStatusSummaryResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return StudentStatusSummaryResponse(
      totalCount:
      (json['totalCount'] as num?)?.toInt() ??
          0,
      enrolledCount:
      (json['enrolledCount'] as num?)
          ?.toInt() ??
          0,
      graduationCount:
      (json['graduationCount'] as num?)
          ?.toInt() ??
          0,
      expulsionCount:
      (json['expulsionCount'] as num?)
          ?.toInt() ??
          0,
      withdrawalCount:
      (json['withdrawalCount'] as num?)
          ?.toInt() ??
          0,
    );
  }
}
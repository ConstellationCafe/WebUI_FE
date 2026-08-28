class TeacherStatusSummaryResponse {
  final int totalCount;
  final int enrolledCount;
  final int retirementCount;
  final int disciplinaryCount;

  const TeacherStatusSummaryResponse({
    required this.totalCount,
    required this.enrolledCount,
    required this.retirementCount,
    required this.disciplinaryCount,
  });

  factory TeacherStatusSummaryResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return TeacherStatusSummaryResponse(
      totalCount:
      (json['totalCount'] as num?)?.toInt() ??
          0,
      enrolledCount:
      (json['enrolledCount'] as num?)
          ?.toInt() ??
          0,
      retirementCount:
      (json['retirementCount'] as num?)
          ?.toInt() ??
          0,
      disciplinaryCount:
      (json['disciplinaryCount'] as num?)
          ?.toInt() ??
          0,
    );
  }
}
import '../../../domain/type/roster_status.dart';

class StatusQueryRequest<T extends RosterStatus> {
  final int? academyId;
  final int? classId;
  final String? academyMemberId;
  final T? status;
  final int page;
  final int size;

  const StatusQueryRequest({
    this.academyId,
    this.classId,
    this.academyMemberId,
    this.status,
    this.page = 1,
    this.size = 20,
  });

  Map<String, dynamic> toJson() {
    return {
      if (academyId != null)
        'academyId': academyId,

      if (classId != null)
        'classId': classId,

      if (academyMemberId != null && academyMemberId!.isNotEmpty)
        'academyMemberId': academyMemberId,

      if (status != null)
        'status': status!.apiValue,

      'page': page,
      'size': size,
    };
  }
}
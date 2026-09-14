import '../../../domain/model/academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/type/roster_status.dart';


class StatusItemResponse<T, K extends RosterStatus> {
  final Academy academy;
  final AcademyClass academyClass;
  final T academyMember;
  final K status;
  final DateTime? statusChangedAt;
  final String? reason;

  const StatusItemResponse({
    required this.academyMember,
    required this.academy,
    required this.academyClass,
    required this.status,
    required this.statusChangedAt,
    required this.reason,
  });

  factory StatusItemResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) academyMemberFromJson,
      K Function(String) academyMemberRosterStatusFromApiValue,
      ) {
    return StatusItemResponse(
      academyMember: academyMemberFromJson(
        json['academyMember'] as Map<String, dynamic>,
      ),
      academy: Academy.fromJson(
        json['academy'] as Map<String, dynamic>,
      ),
      academyClass: AcademyClass.fromJson(
        json['academyClass']
        as Map<String, dynamic>,
      ),
      status: academyMemberRosterStatusFromApiValue(
          json['status'] as String
      ),
      statusChangedAt:
      json['statusChangedAt'] == null
          ? null
          : DateTime.parse(
        json['statusChangedAt'] as String,
      ),
      reason: json['reason'] as String?,
    );
  }
}
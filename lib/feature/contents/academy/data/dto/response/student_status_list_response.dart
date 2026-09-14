import 'package:constellation_cafe/feature/contents/academy/domain/type/student_roster_status.dart';

import '../../../domain/model/student.dart';
import 'status_item_response.dart';
import 'status_pagination_response.dart';
import 'student_status_summary_response.dart';

class StudentStatusListResponse {
  final List<StatusItemResponse<Student, StudentRosterStatus>> items;
  final StudentStatusSummaryResponse summary;
  final StatusPaginationResponse pagination;

  const StudentStatusListResponse({
    required this.items,
    required this.summary,
    required this.pagination,
  });

  factory StudentStatusListResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    final itemsJson =
        json['items'] as List<dynamic>? ?? [];

    return StudentStatusListResponse(
      items: itemsJson
        .map<StatusItemResponse<Student, StudentRosterStatus>>(
          (item) => StatusItemResponse<Student, StudentRosterStatus>
            .fromJson(
              item as Map<String, dynamic>,
              Student.fromJson,
              StudentRosterStatus.fromApiValue,
            ),
        )
        .toList(),
      summary: StudentStatusSummaryResponse.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      pagination: StatusPaginationResponse.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );
  }
}
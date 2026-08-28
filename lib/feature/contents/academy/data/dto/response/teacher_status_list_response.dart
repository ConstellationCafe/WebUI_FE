import 'package:constellation_cafe/feature/contents/academy/domain/type/teacher_roster_status.dart';

import '../../../domain/model/teacher.dart';
import 'status_item_response.dart';
import 'status_pagination_response.dart';
import 'teacher_status_summary_response.dart';

class TeacherStatusListResponse {
  final List<StatusItemResponse> items;
  final TeacherStatusSummaryResponse summary;
  final StatusPaginationResponse pagination;

  const TeacherStatusListResponse({
    required this.items,
    required this.summary,
    required this.pagination,
  });

  factory TeacherStatusListResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];

    return TeacherStatusListResponse(
      items: itemsJson
        .map(
          (item) =>
            StatusItemResponse.fromJson(
              item as Map<String, dynamic>,
              Teacher.fromJson,
              TeacherRosterStatus.fromApiValue
            ),
        )
          .toList(),
      summary: TeacherStatusSummaryResponse.fromJson(
        json['summary']
        as Map<String, dynamic>,
      ),
      pagination: StatusPaginationResponse.fromJson(
        json['pagination']
        as Map<String, dynamic>,
      ),
    );
  }
}
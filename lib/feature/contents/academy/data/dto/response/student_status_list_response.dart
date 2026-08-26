import 'student_status_item_response.dart';
import 'student_status_pagination_response.dart';
import 'student_status_summary_response.dart';

class StudentStatusListResponse {
  final List<StudentStatusItemResponse> items;
  final StudentStatusSummaryResponse summary;
  final StudentStatusPaginationResponse pagination;

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
          .map(
            (item) =>
            StudentStatusItemResponse.fromJson(
              item as Map<String, dynamic>,
            ),
      )
          .toList(),
      summary:
      StudentStatusSummaryResponse.fromJson(
        json['summary']
        as Map<String, dynamic>,
      ),
      pagination:
      StudentStatusPaginationResponse.fromJson(
        json['pagination']
        as Map<String, dynamic>,
      ),
    );
  }
}
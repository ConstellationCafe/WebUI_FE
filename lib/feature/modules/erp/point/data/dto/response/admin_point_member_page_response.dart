import 'admin_point_member_response.dart';

class AdminPointMemberPageResponse {
  final List<AdminPointMemberResponse> items;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool hasNext;

  const AdminPointMemberPageResponse({
    required this.items,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.hasNext,
  });

  factory AdminPointMemberPageResponse.fromJson(Map<String, dynamic> json) {
    return AdminPointMemberPageResponse(
      items: (json['items'] as List<dynamic>)
          .map(
            (item) =>
                AdminPointMemberResponse.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
    );
  }
}

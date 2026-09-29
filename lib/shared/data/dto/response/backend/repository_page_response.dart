import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';

/// DB 편집기 저장소 API(`/api/repository/**/list`, `point_log`)의 페이지 응답.
///
/// ```json
/// {"success": true, "response": {"metadata": [...], "entities": [...],
///  "page": 1, "size": 20, "totalElements": 21, "totalPages": 2, "hasNext": true}}
/// ```
/// `metadata`는 컬럼 정의(`colName`, `isPrimary`, `isNullable`)이고, 컬럼 구성이 저장소마다
/// 달라 각 저장소가 화면용 컬럼명으로 바꾼 뒤 DB 편집기에 넘긴다.
class RepositoryPageResponse {
  final List<Map<String, dynamic>> metadata;
  final List<Map<String, dynamic>> entities;
  final int? page;
  final int? size;
  final int totalElements;
  final int totalPages;
  final bool hasNext;

  const RepositoryPageResponse({
    required this.metadata,
    required this.entities,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.hasNext,
  });

  /// 응답 본문을 해석한다. 실패 응답이면 서버 메시지를 담은 예외를 던진다.
  factory RepositoryPageResponse.fromJson(dynamic res) {
    if (res['success'] != true) {
      final err = res['error'];
      final msg = (err is Map<String, dynamic>)
          ? (err['message']?.toString() ?? 'unknown')
          : 'unknown';
      throw Exception('API error: $msg');
    }

    final body = res['response'];
    final List rawMeta = (body['metadata'] as List?)?.toList() ?? const [];
    final List rawEntities = (body['entities'] as List?)?.toList() ?? const [];

    return RepositoryPageResponse(
      metadata: rawMeta
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      entities: rawEntities
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      page: (body['page'] as num?)?.toInt(),
      size: (body['size'] as num?)?.toInt(),
      totalElements: (body['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (body['totalPages'] as num?)?.toInt() ?? 0,
      hasNext: body['hasNext'] == true,
    );
  }

  /// 저장소가 변환한 [items]와 화면용 [columns]로 DB 편집기 페이지를 만든다.
  /// 서버가 page·size를 주지 않으면 요청한 값을 쓴다.
  PageResult<T> toPageResult<T>({
    required List<T> items,
    required List<Map<String, dynamic>> columns,
    required int requestedPage,
    required int requestedSize,
  }) {
    return PageResult<T>(
      items: items,
      metadata: columns,
      page: page ?? requestedPage,
      size: size ?? requestedSize,
      totalElements: totalElements,
      totalPages: totalPages,
      hasNext: hasNext,
    );
  }
}

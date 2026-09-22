import 'package:dio/dio.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import '../../../../../shared/domain/pagination/page_result.dart';
import '../domain/entity/learning_entity.dart';

class LearningRepository implements RepositoryInterface<LearningEntity> {
  static String apiPath = "/api/repository/learning";

  final Dio dio;

  LearningRepository({required this.dio});

  @override
  Future<PageResult<LearningEntity>> findPage({
    required int page,
    required int size,
    String? searchColumn,
    String? searchValue,
    String? sortColumn,
    String? sortDirection,
  }) async {
    final response = await dio.get(
      "$apiPath/list",
      queryParameters: {
        'page': page,
        'size': size,

        if (searchColumn != null && searchColumn.isNotEmpty)
          'searchColumn': _toApiColumnName(searchColumn),

        if (searchValue != null && searchValue.isNotEmpty)
          'searchValue': searchValue,

        if (sortColumn != null && sortColumn.isNotEmpty)
          'sortColumn': _toApiColumnName(sortColumn),

        if (sortDirection != null && sortDirection.isNotEmpty)
          'sortDirection': sortDirection,
      },
    );

    final res = response.data;

    if (res['success'] != true) {
      final err = res['error'];

      final msg = (err is Map<String, dynamic>)
          ? (err['message']?.toString() ?? 'unknown')
          : 'unknown';

      throw Exception('API error: $msg');
    }

    final body = res['response'];

    final List rawMeta = (body['metadata'] as List?)?.toList() ?? const [];

    final List<Map<String, dynamic>> metadata = rawMeta
        .map((e) => Map<String, dynamic>.from(e as Map))
        .map((m) {
          final dbName = m['colName'].toString();

          // 실제 API/DB 컬럼명 보존
          m['dbName'] = dbName;

          // DBEditor에서 사용할 이름
          if (dbName == 'ln_key') {
            m['colName'] = 'lnKey';
          } else if (dbName == 'ln_value') {
            m['colName'] = 'lnValue';
          } else if (dbName == 'teacher') {
            m['colName'] = 'discordId';
          }

          return m;
        })
        .toList();

    final List rawEntities = (body['entities'] as List?)?.toList() ?? const [];

    final entities = rawEntities
        .map(
          (e) => LearningEntity.fromJson(
            metadata,
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();

    return PageResult<LearningEntity>(
      items: entities,
      metadata: metadata,
      page: (body['page'] as num?)?.toInt() ?? page,
      size: (body['size'] as num?)?.toInt() ?? size,
      totalElements: (body['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (body['totalPages'] as num?)?.toInt() ?? 0,
      hasNext: body['hasNext'] == true,
    );
  }

  @override
  Future<dynamic> save(LearningEntity entity) async {
    final res = await dio.post("$apiPath/save", data: [entity.toJson()]);

    return res.data;
  }

  @override
  Future<dynamic> saveAll(List<Map<String, String>> model) async {
    final data = model.map(_toApiJson).toList();

    final res = await dio.post("$apiPath/save_all", data: data);

    return res.data;
  }

  @override
  Future<dynamic> deleteAll(List<Map<String, String>> model) async {
    final data = model.map(_toApiJson).toList();

    final res = await dio.post("$apiPath/delete_all", data: data);

    return res.data;
  }

  Map<String, String> _toApiJson(Map<String, String> row) {
    return {
      'lnKey': row['lnKey'] ?? '',
      'lnValue': row['lnValue'] ?? '',

      // DBEditor -> API
      'teacher': row['discordId'] ?? '',
    };
  }

  String _toApiColumnName(String column) {
    switch (column) {
      case 'discordId':
        return 'teacher';

      default:
        return column;
    }
  }
}

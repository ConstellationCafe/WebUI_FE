import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/repository_page_response.dart';
import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../domain/entity/learning_entity.dart';

final learningRepositoryProvider = Provider<RepositoryInterface>(
  (ref) => LearningRepository(dio: ref.watch(dioProvider)),
);

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

    final result = RepositoryPageResponse.fromJson(response.data);

    final List<Map<String, dynamic>> metadata = result.metadata.map((m) {
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
    }).toList();

    final entities = result.entities
        .map((json) => LearningEntity.fromJson(metadata, json))
        .toList();

    return result.toPageResult<LearningEntity>(
      items: entities,
      columns: metadata,
      requestedPage: page,
      requestedSize: size,
    );
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

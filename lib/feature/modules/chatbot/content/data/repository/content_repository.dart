import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/repository_page_response.dart';
import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../domain/entity/content_entity.dart';

final contentRepositoryProvider = Provider<RepositoryInterface>(
  (ref) => ContentRepository(dio: ref.watch(dioProvider)),
);

class ContentRepository implements RepositoryInterface<ContentEntity> {
  static String apiPath = "/api/repository/content";

  final Dio dio;

  ContentRepository({required this.dio});

  @override
  Future<PageResult<ContentEntity>> findPage({
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

      m['dbName'] = dbName;

      if (dbName == 'cn_value') {
        m['colName'] = 'cnValue';
      } else if (dbName == 'recommender') {
        m['colName'] = 'discordId';
      }

      return m;
    }).toList();

    final entities = result.entities
        .map((json) => ContentEntity.fromJson(metadata, json))
        .toList();

    return result.toPageResult<ContentEntity>(
      items: entities,
      columns: metadata,
      requestedPage: page,
      requestedSize: size,
    );
  }

  @override
  Future<dynamic> saveAll(List<Map<String, String>> model) async {
    final res = await dio.post(
      "$apiPath/save_all",
      data: model.map(_toApiJson).toList(),
    );

    return res.data;
  }

  @override
  Future<dynamic> deleteAll(List<Map<String, String>> model) async {
    final res = await dio.post(
      "$apiPath/delete_all",
      data: model.map(_toApiJson).toList(),
    );

    return res.data;
  }

  String _toApiColumnName(String column) {
    if (column == 'discordId') {
      return 'recommender';
    }

    return column;
  }

  Map<String, dynamic> _toApiJson(Map<String, dynamic> json) {
    return {
      'cnValue': json['cnValue'] ?? '',
      'recommender': json['discordId'] ?? '',
    };
  }
}

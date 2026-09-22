import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import '../../../../../shared/domain/pagination/page_result.dart';
import '../domain/entity/music_entity.dart';
import 'package:dio/dio.dart';

class MusicRepository implements RepositoryInterface<MusicEntity> {
  static String apiPath = "/api/repository/music";

  final Dio dio;

  MusicRepository({required this.dio});

  @override
  Future<PageResult<MusicEntity>> findPage({
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

          m['dbName'] = dbName;

          if (dbName == 'video_id') {
            m['colName'] = 'videoId';
          } else if (dbName == 'recommender') {
            m['colName'] = 'discordId';
          }

          return m;
        })
        .toList();

    final List rawEntities = (body['entities'] as List?)?.toList() ?? const [];

    final List<MusicEntity> entities = rawEntities
        .map(
          (e) => MusicEntity.fromJson(
            metadata,
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();

    return PageResult<MusicEntity>(
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
  Future<dynamic> save(MusicEntity entity) async {
    final res = await dio.post(
      "$apiPath/save",
      data: [_toApiJson(entity.toJson())],
    );

    return res.data;
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
      'videoId': json['videoId'] ?? '',
      'recommender': json['discordId'] ?? '',
    };
  }
}

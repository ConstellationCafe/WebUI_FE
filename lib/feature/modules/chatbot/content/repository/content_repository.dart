
import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';
import 'package:dio/dio.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import '../domain/entity/content_entity.dart';


class ContentRepository implements RepositoryInterface<ContentEntity> {
  static String apiPath = "/api/repository/content";
  final Dio dio;

  ContentRepository({
    required this.dio
  });

  // @override
  // Future<List<ContentEntity>> findAll() async {
  //   final response = await dio.get("$apiPath/list");
  //   final res = response.data;
  //
  //   if (res['success'] == true) {
  //     final List rawMeta = (res['response']?['metadata'] as List?)?.toList() ?? const [];
  //     final List<Map<String, dynamic>> metadata = rawMeta
  //         .map((e) => Map<String, dynamic>.from(e as Map))
  //         .map((m) {
  //           // 실제 DB 컬럼명을 DBModel 컬럼명으로 변환
  //           final col = m['colName'];
  //           if (col == 'cn_value') {
  //             m['colName'] = 'cnValue';
  //           }
  //           return m;
  //         }).toList();
  //     final List entities = (res['response']['entities'] as List?)?.toList() ?? const [];
  //     if (entities.isNotEmpty) {
  //       return entities
  //           .map((e) => ContentEntity.fromJson(metadata, e))
  //           .toList();
  //     } else {
  //       return [ContentEntity.init(metadata)];
  //     }
  //
  //   } else {
  //     final err = res['error'];
  //     final msg = (err is Map<String, dynamic>) ? (err['message']?.toString() ?? 'unknown') : 'unknown';
  //     throw Exception('API error: $msg');
  //   }
  // }

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
          'searchColumn': searchColumn,
        if (searchValue != null && searchValue.isNotEmpty)
          'searchValue': searchValue,
        if (sortColumn != null && sortColumn.isNotEmpty)
          'sortColumn': sortColumn,
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
    final List rawMeta = (body['metadata'] as List?)?.toList()
            ?? const [];
    final List<Map<String, dynamic>> metadata = rawMeta
        .map((e) => Map<String, dynamic>.from(e as Map))
        .map((m) {
          final dbName = m['colName'].toString();
          // 실제 DB 컬럼명 보존
          m['dbName'] = dbName;
          // Entity / DBModel에서 사용하는 이름
          if (dbName == 'cn_value') {
            m['colName'] = 'cnValue';
          }
          return m;
        })
        .toList();

    final List rawEntities = (body['entities'] as List?)?.toList()
            ?? const [];
    final List<ContentEntity> entities = rawEntities
        .map(
          (e) => ContentEntity.fromJson(
            metadata,
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();

    return PageResult<ContentEntity>(
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
  Future<dynamic> save(ContentEntity entity) async {
    final res = await dio.post("$apiPath/save", data: [entity.toJson()]);
    return res.data;
  }

  @override
  Future<dynamic> saveAll(List<Map<String, String>> model) async {
    final res = await dio.post("$apiPath/save_all", data: model);
    return res.data;
  }

  @override
  Future<dynamic> deleteAll(List<Map<String, String>> model) async {
    final res = await dio.post("$apiPath/delete_all", data: model);
    return res.data;
  }
}
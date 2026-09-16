
import 'package:constellation_cafe/feature/profile/domain/entity/point_entity.dart';
import 'package:dio/dio.dart';
import '../../../../shared/domain/repository/repository_interface.dart';
import '../../../shared/domain/pagination/page_result.dart';


class PointRepository implements RepositoryInterface<PointEntity> {
  static String apiPath = "/api/repository/membership";
  final Dio dio;

  PointRepository({
    required this.dio
  });

  // @override
  // Future<List<PointEntity>> findAll() async {
  //   final response = await dio.get("$apiPath/point_log");
  //   final res = response.data;
  //
  //   if (res['success'] == true) {
  //     final List rawMeta = (res['response']?['metadata'] as List?)?.toList() ?? const [];
  //     final List<Map<String, dynamic>> metadata = rawMeta
  //         .map((e) => Map<String, dynamic>.from(e as Map))
  //         .map((m) {
  //           // 실제 DB 컬럼명을 DBModel 컬럼명으로 변환
  //           final col = m['colName'];
  //           if (col == 'amount') {
  //             m['colName'] = '변동 금액';
  //           }
  //           if (col == 'at') {
  //             m['colName'] = '변동 일자';
  //           }
  //           if (col == 'description') {
  //             m['colName'] = '변동 내용';
  //           }
  //           return m;
  //         }).toList();
  //     final List entities = (res['response']['entities'] as List?)?.toList() ?? const [];
  //     if (entities.isNotEmpty) {
  //       return entities
  //           .map((e) => PointEntity.fromJson(metadata, e))
  //           .toList();
  //     } else {
  //       return [PointEntity.init(metadata)];
  //     }
  //
  //   } else {
  //     final err = res['error'];
  //     final msg = (err is Map<String, dynamic>) ? (err['message']?.toString() ?? 'unknown') : 'unknown';
  //     throw Exception('API error: $msg');
  //   }
  // }

  @override
  Future<PageResult<PointEntity>> findPage({
    required int page,
    required int size,
    String? searchColumn,
    String? searchValue,
    String? sortColumn,
    String? sortDirection,
  }) async {
    final response = await dio.get(
      "$apiPath/point_log",
      queryParameters: {
        'page': page,
        'size': size,
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
    final List rawMeta =
        (body['metadata'] as List?)?.toList() ?? const [];
    final List<Map<String, dynamic>> metadata = rawMeta
        .map((e) => Map<String, dynamic>.from(e as Map))
        .map((m) {
          final col = m['colName'];
          if (col == 'amount') {
            m['colName'] = '변동 금액';
          } else if (col == 'at') {
            m['colName'] = '변동 일자';
          } else if (col == 'description') {
            m['colName'] = '변동 내용';
          }
          return m;
        })
        .toList();

    final List rawEntities =
        (body['entities'] as List?)?.toList() ?? const [];

    final List<PointEntity> entities = rawEntities
        .map(
          (e) => PointEntity.fromJson(
            metadata,
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();

    return PageResult<PointEntity>(
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
  Future<dynamic> save(PointEntity entity) async {
    // final res = await dio.post("$apiPath/save", data: [entity.toJson()]);
    // return res.data;
  }

  @override
  Future<dynamic> saveAll(List<Map<String, String>> model) async {
    // final res = await dio.post("$apiPath/save_all", data: model);
    // return res.data;
  }

  @override
  Future<dynamic> deleteAll(List<Map<String, String>> model) async {
    // final res = await dio.post("$apiPath/delete_all", data: model);
    // return res.data;
  }
}
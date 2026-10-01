import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/network/dio_provider.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/repository_page_response.dart';
import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/point_log_columns.dart';
import '../../domain/entity/point_entity.dart';

final pointRepositoryProvider = Provider<RepositoryInterface>(
  (ref) => PointRepository(dio: ref.watch(dioProvider)),
);

class PointRepository implements RepositoryInterface<PointEntity> {
  static String apiPath = "/api/repository/membership";
  final Dio dio;

  PointRepository({required this.dio});

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
      queryParameters: {'page': page, 'size': size},
    );
    final result = RepositoryPageResponse.fromJson(response.data);

    final List<Map<String, dynamic>> metadata = result.metadata.map((m) {
      final col = m['colName'];
      if (col == 'amount') {
        m['colName'] = PointLogColumns.amount;
      } else if (col == 'at') {
        m['colName'] = PointLogColumns.at;
      } else if (col == 'description') {
        m['colName'] = PointLogColumns.description;
      }

      return m;
    }).toList();

    final entities = result.entities
        .map((json) => PointEntity.fromJson(metadata, json))
        .toList();

    return result.toPageResult<PointEntity>(
      items: entities,
      columns: metadata,
      requestedPage: page,
      requestedSize: size,
    );
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

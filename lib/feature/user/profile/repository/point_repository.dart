
import 'package:constellation_cafe/feature/user/profile/domain/entity/point_entity.dart';
import 'package:dio/dio.dart';
import '../../../../shared/domain/repository/repository_interface.dart';


class PointRepository implements RepositoryInterface<PointEntity> {
  static String apiPath = "/api/repository/membership";
  final Dio dio;

  PointRepository({
    required this.dio
  });

  @override
  Future<List<PointEntity>> findAll() async {
    final response = await dio.get("$apiPath/point_log");
    final res = response.data;

    if (res['success'] == true) {
      final List rawMeta = (res['response']?['metadata'] as List?)?.toList() ?? const [];
      final List<Map<String, dynamic>> metadata = rawMeta
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map((m) {
            // 실제 DB 컬럼명을 DBModel 컬럼명으로 변환
            final col = m['colName'];
            if (col == 'amount') {
              m['colName'] = '변동 금액';
            }
            if (col == 'at') {
              m['colName'] = '변동 일자';
            }
            if (col == 'description') {
              m['colName'] = '변동 내용';
            }
            return m;
          }).toList();
      final List entities = (res['response']['entities'] as List?)?.toList() ?? const [];
      if (entities.isNotEmpty) {
        return entities
            .map((e) => PointEntity.fromJson(metadata, e))
            .toList();
      } else {
        return [PointEntity.init(metadata)];
      }

    } else {
      final err = res['error'];
      final msg = (err is Map<String, dynamic>) ? (err['message']?.toString() ?? 'unknown') : 'unknown';
      throw Exception('API error: $msg');
    }
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
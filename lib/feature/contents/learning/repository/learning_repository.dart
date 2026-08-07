
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/feature/contents/learning/domain/entity/learning_entity.dart';
import 'package:dio/dio.dart';


class LearningRepository implements RepositoryInterface<LearningEntity> {
  static String apiPath = "/api/repository/learning";
  final Dio dio;

  LearningRepository({
    required this.dio
  });

  @override
  Future<List<LearningEntity>> findAll() async {
    final response = await dio.get("$apiPath/list");
    final res = response.data;

    if (res['success'] == true) {
      final List rawMeta = (res['response']?['metadata'] as List?)?.toList() ?? const [];
      final List<Map<String, dynamic>> metadata = rawMeta
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map((m) {
            // 실제 DB 컬럼명을 DBModel 컬럼명으로 변환
            final col = m['colName'];
            if (col == 'ln_key') {
              m['colName'] = 'lnKey';
            } else if (col == 'ln_value') {
              m['colName'] = 'lnValue';
            }
            return m;
          }).toList();
      final List entities = (res['response']['entities'] as List?)?.toList() ?? const [];
      if (entities.isNotEmpty) {
        return entities
            .map((e) => LearningEntity.fromJson(metadata, e))
            .toList();
      } else {
        return [LearningEntity.init(metadata)];
      }
    } else {
      final err = res['error'];
      final msg = (err is Map<String, dynamic>) ? (err['message']?.toString() ?? 'unknown') : 'unknown';
      throw Exception('API error: $msg');
    }
  }

  @override
  Future<dynamic> save(LearningEntity entity) async {
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
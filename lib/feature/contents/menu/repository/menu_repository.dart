
import 'package:dio/dio.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/feature/contents/menu/domain/entity/menu_entity.dart';


class MenuRepository implements RepositoryInterface<MenuEntity> {
  static String apiPath = "/api/repository/menu";
  final Dio dio;

  MenuRepository({
    required this.dio
  });

  @override
  Future<List<MenuEntity>> findAll() async {
    final response = await dio.get("$apiPath/list");
    final res = response.data;

    if (res['success'] == true) {
      final List rawMeta = (res['response']?['metadata'] as List?)?.toList() ?? const [];
      final List<Map<String, dynamic>> metadata = rawMeta
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map((m) {
            // 실제 DB 컬럼명을 DBModel 컬럼명으로 변환
            final col = m['colName'];
            if (col == 'mn_value') {
              m['colName'] = 'mnValue';
            }
            return m;
          }).toList();
      final List entities = (res['response']['entities'] as List?)?.toList() ?? const [];
      if (entities.isNotEmpty) {
        return entities
            .map((e) => MenuEntity.fromJson(metadata, e))
            .toList();
      } else {
        return [MenuEntity.init(metadata)];
      }

    } else {
      final err = res['error'];
      final msg = (err is Map<String, dynamic>) ? (err['message']?.toString() ?? 'unknown') : 'unknown';
      throw Exception('API error: $msg');
    }
  }

  @override
  Future<dynamic> save(MenuEntity entity) async {
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
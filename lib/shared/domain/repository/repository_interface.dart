import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';
import '../pagination/page_result.dart';


abstract class RepositoryInterface<T extends Entity> {
  Future<List<T>> findAll();
  Future<PageResult<T>> findPage({
    required int page,
    required int size,
    String? searchColumn,
    String? searchValue,
    String? sortColumn,
    String? sortDirection,
  });
  Future<void> save(T entity);
  Future<dynamic> saveAll(List<Map<String, String>> model);
  Future<dynamic> deleteAll(List<Map<String, String>> model);
}
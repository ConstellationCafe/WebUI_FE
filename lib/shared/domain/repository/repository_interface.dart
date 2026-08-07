
import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

abstract class RepositoryInterface<T extends Entity> {
  Future<List<T>> findAll();
  Future<void> save(T entity);
  Future<dynamic> saveAll(List<Map<String, String>> model);
  Future<dynamic> deleteAll(List<Map<String, String>> model);
}
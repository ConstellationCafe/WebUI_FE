
import 'package:constellation_cafe/data/model/entity/EntityInterface.dart';

abstract class RepositoryInterface {
  Future<List<Entity>> findAll();

  Future<dynamic> save(Entity entity);
  Future<dynamic> saveAll(List<Map<String, String>> model);
  Future<dynamic> deleteAll(List<Map<String, String>> model);
}
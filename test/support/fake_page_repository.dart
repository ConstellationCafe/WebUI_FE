import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';
import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

/// DBEditor 화면 테스트용 저장소. 네트워크 없이 준비한 페이지를 돌려준다.
///
/// 응답 JSON 변환은 각 기능의 API 테스트에서 검증한다.
class FakePageRepository<T extends Entity> implements RepositoryInterface<T> {
  FakePageRepository(this.result);

  final PageResult<T> result;
  final List<int> requestedPages = [];

  @override
  Future<PageResult<T>> findPage({
    required int page,
    required int size,
    String? searchColumn,
    String? searchValue,
    String? sortColumn,
    String? sortDirection,
  }) async {
    requestedPages.add(page);
    return result;
  }

  @override
  Future<dynamic> saveAll(List<Map<String, String>> model) async => null;

  @override
  Future<dynamic> deleteAll(List<Map<String, String>> model) async => null;
}

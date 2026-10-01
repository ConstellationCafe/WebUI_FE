import 'package:constellation_cafe/feature/module_config/data/api/module_config_api.dart';
import 'package:constellation_cafe/feature/module_config/data/repository/module_config_repository.dart';
import 'package:constellation_cafe/feature/module_config/domain/model/module_availability.dart';

/// HTTP 없이 채팅방별 메뉴 응답과 완료 순서를 제어한다.
class FakeModuleConfigRepository implements ModuleConfigRepository {
  ModuleAvailability availability = const ModuleAvailability(
    chatbot: true,
    shadowverse: true,
    academy: true,
    competition: true,
  );
  int calls = 0;
  Object? error;
  final List<Future<ModuleAvailability>> replies = [];

  @override
  ModuleConfigApi get api => throw UnimplementedError();

  @override
  Future<ModuleAvailability> getAvailability() async {
    calls++;
    if (replies.isNotEmpty) return replies.removeAt(0);
    final failure = error;
    if (failure != null) throw failure;
    return availability;
  }
}

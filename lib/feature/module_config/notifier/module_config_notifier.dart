import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/competition/notifier/competition_permission_notifier.dart';

import '../data/repository/module_config_repository_provider.dart';
import '../domain/model/module_availability.dart';

part 'module_config_notifier.g.dart';

/// 채팅방의 메뉴 설정은 화면 이동 중 유지하고, 로그인·방 변경 때 다시 읽는다.
/// 활성화된 모듈에 한해서 별도 권한을 조회한다.
@Riverpod(keepAlive: true)
class ModuleConfigNotifier extends _$ModuleConfigNotifier {
  int _request = 0;

  @override
  AsyncValue<ModuleAvailability> build() =>
      const AsyncData(ModuleAvailability());

  Future<void> load() async {
    final request = ++_request;
    _clearPermissions();
    state = const AsyncLoading();
    try {
      final modules = await ref
          .read(moduleConfigRepositoryProvider)
          .getAvailability();
      if (!ref.mounted || request != _request) return;
      state = AsyncData(modules);
      await Future.wait([
        if (modules.academy)
          ref.read(academyPermissionProvider.notifier).initialize(),
        if (modules.competition)
          ref.read(competitionPermissionProvider.notifier).load(),
      ]);
    } catch (error, stackTrace) {
      if (!ref.mounted || request != _request) return;
      state = AsyncError(error, stackTrace);
    }
  }

  void clear() {
    _request++;
    state = const AsyncData(ModuleAvailability());
    _clearPermissions();
  }

  void _clearPermissions() {
    ref.read(academyPermissionProvider.notifier).clear();
    ref.read(competitionPermissionProvider.notifier).clear();
  }
}

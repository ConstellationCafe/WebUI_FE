import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repository/penalty_repository_provider.dart';
import '../state/penalty_permission_state.dart';

part 'penalty_permission_notifier.g.dart';

/// 벌점 관리 메뉴·화면 표시 여부. 대회 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(ModuleConfigNotifier).
@Riverpod(keepAlive: true)
class PenaltyPermissionNotifier extends _$PenaltyPermissionNotifier {
  int _request = 0;

  @override
  PenaltyPermissionState build() => const PenaltyPermissionState();

  /// 권한을 다시 조회한다. 채팅방마다 역할이 다르므로 이미 불러왔어도 새로 묻는다.
  /// 조회에 실패하면 권한 없음으로 두어 메뉴를 숨긴다.
  Future<void> load() async {
    final request = ++_request;
    state = const PenaltyPermissionState(isLoading: true);
    try {
      final isManager = await ref.read(penaltyRepositoryProvider).isManager();
      if (!ref.mounted || request != _request) return;
      state = PenaltyPermissionState(isInitialized: true, isManager: isManager);
    } catch (_) {
      if (!ref.mounted || request != _request) return;
      state = const PenaltyPermissionState(isInitialized: true);
    }
  }

  void clear() {
    _request++;
    state = const PenaltyPermissionState();
  }
}

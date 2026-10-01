import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repository/competition_repository_provider.dart';
import '../state/competition_permission_state.dart';

part 'competition_permission_notifier.g.dart';

/// 대회 메뉴 표시 여부. 아카데미 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(CurrentUserStateNotifier).
@Riverpod(keepAlive: true)
class CompetitionPermissionNotifier extends _$CompetitionPermissionNotifier {
  int _request = 0;

  @override
  CompetitionPermissionState build() => const CompetitionPermissionState();

  /// 권한을 다시 조회한다. 채팅방마다 역할이 다르므로 이미 불러왔어도 새로 묻는다.
  /// 조회에 실패하면 권한 없음으로 두어 메뉴를 숨긴다.
  Future<void> load() async {
    final request = ++_request;
    state = const CompetitionPermissionState(isLoading: true);
    try {
      final isManager = await ref
          .read(competitionRepositoryProvider)
          .isManager();
      if (!ref.mounted || request != _request) return;
      state = CompetitionPermissionState(
        isInitialized: true,
        isManager: isManager,
      );
    } catch (_) {
      if (!ref.mounted || request != _request) return;
      state = const CompetitionPermissionState(isInitialized: true);
    }
  }

  void clear() {
    _request++;
    state = const CompetitionPermissionState();
  }
}

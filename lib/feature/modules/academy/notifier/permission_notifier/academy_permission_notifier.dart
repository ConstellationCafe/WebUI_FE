import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/academy_strings.dart';
import '../../data/api/academy_api.dart';
import '../../state/permission_state/academy_permission_state.dart';

part 'academy_permission_notifier.g.dart';

/// 여러 아카데미 화면에서 공유하며, 방 변경·로그아웃 때 명시적으로 비운다.
@Riverpod(keepAlive: true)
class AcademyPermissionNotifier extends _$AcademyPermissionNotifier {
  int _request = 0;

  @override
  AcademyPermissionState build() {
    return AcademyPermissionState.initial();
  }

  Future<void> initialize() async {
    if (state.isInitialized || state.isLoading) {
      return;
    }

    await _load();
  }

  Future<void> refresh() async {
    if (state.isLoading) {
      return;
    }

    await _load();
  }

  Future<void> _load() async {
    final request = ++_request;
    state = const AcademyPermissionState(isLoading: true);

    try {
      final academyApi = ref.read(academyApiProvider);

      final permission = await academyApi.getMyPermissions();
      if (!ref.mounted || request != _request) return;

      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        permission: permission,
        errorMessage: null,
      );
    } catch (_) {
      if (!ref.mounted || request != _request) return;
      state = const AcademyPermissionState(
        errorMessage: AcademyStrings.loadFailed,
      );
    }
  }

  void clear() {
    _request++;
    state = AcademyPermissionState.initial();
  }
}

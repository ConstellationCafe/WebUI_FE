import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../state/permission_state/academy_permission_state.dart';

part 'academy_permission_notifier.g.dart';

@Riverpod(keepAlive: true)
class AcademyPermissionNotifier
    extends _$AcademyPermissionNotifier {

  @override
  AcademyPermissionState build() {
    return AcademyPermissionState.initial();
  }

  Future<void> initialize() async {
    if (state.isInitialized || state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final academyApi = ref.read(
        academyApiProvider,
      );

      final permission =
      await academyApi.getMyPermissions();

      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        permission: permission,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final academyApi = ref.read(
        academyApiProvider,
      );

      final permission =
      await academyApi.getMyPermissions();

      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        permission: permission,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clear() {
    state = AcademyPermissionState.initial();
  }
}
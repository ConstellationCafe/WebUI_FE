import 'package:freezed_annotation/freezed_annotation.dart';

part 'competition_permission_state.freezed.dart';

/// 현재 채팅방에서 내 대회 기능 권한. 메뉴 표시용이며 최종 판단은 서버가 한다.
@freezed
abstract class CompetitionPermissionState with _$CompetitionPermissionState {
  const factory CompetitionPermissionState({
    @Default(false) bool isLoading,
    @Default(false) bool isInitialized,

    /// 대회 매니저 역할(또는 서버장)이 있어 대회 기능을 쓸 수 있는지
    @Default(false) bool isManager,
  }) = _CompetitionPermissionState;
}

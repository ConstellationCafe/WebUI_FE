import 'package:freezed_annotation/freezed_annotation.dart';

part 'penalty_permission_state.freezed.dart';

/// 현재 채팅방에서 내 벌점 관리 권한. 메뉴 표시용이며 최종 판단은 서버가 한다.
@freezed
abstract class PenaltyPermissionState with _$PenaltyPermissionState {
  const factory PenaltyPermissionState({
    @Default(false) bool isLoading,
    @Default(false) bool isInitialized,

    /// 운영 매니저·운영 본부원 역할(또는 서버장)이 있어 벌점을 관리할 수 있는지
    @Default(false) bool isManager,
  }) = _PenaltyPermissionState;
}

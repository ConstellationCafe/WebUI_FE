import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../State/State.dart';


class FriendlyMatchStateNotifier extends StateNotifier<FriendlyMatchState> {
  /// 생성자
  FriendlyMatchStateNotifier()
      : super(FriendlyMatchState.initial());

  /// 상태 업데이트
  void update({
    String? version,
    String? mode,
    String? platform,
    String? roomNumber,
    String? message,
    String? sender,
  }) {
    // 이 경우엔 sender는 다시 못 채움, 기존 state로부터 참조
    final baseState =
      version != null ? FriendlyMatchState.initial() : state;

    state = baseState.copyWith(
      version: version ?? baseState.version,
      mode: mode ?? baseState.mode,
      platform: platform ?? baseState.platform,
      roomNumber: roomNumber ?? baseState.roomNumber,
      message: message ?? baseState.message,
      sender: sender ?? state.sender,
    );
  }

  /// JSON으로부터 상태 세팅
  void setFromJson(Map<String, dynamic> json) {
    state = FriendlyMatchState.fromJson(json);
  }

  /// 상태를 JSON으로 export
  Map<String, dynamic> toJson() {
    return state.toJson();
  }

  /// 초기화
  void clear() {
    state = FriendlyMatchState.initial();
  }
}

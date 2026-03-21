import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/Notifier/global_state_notifier.dart';
import '../State/friendly_match_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friendly_match_notifier.g.dart';

@riverpod
class FriendlyMatchNotifier extends _$FriendlyMatchNotifier {
  @override
  FriendlyMatchState build() {
    // globalStateProvider에서 이름을 감시하여 초기 sender 설정
    final globalName = ref.watch(globalStateProvider.select((s) => s.globalName));

    return FriendlyMatchState.initial().copyWith(sender: globalName);
  }

  /// 상태 업데이트
  void update({
    String? version,
    String? mode,
    String? platform,
    String? roomNumber,
    String? message,
    String? sender,
  }) {
    // version이 새로 들어오면 초기 상태에서 시작, 아니면 현재 state 유지
    final baseState = version != null ? FriendlyMatchState.initial() : state;

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
    final globalName = ref.read(globalStateProvider).globalName;
    state = FriendlyMatchState.initial().copyWith(sender: globalName);
  }
}
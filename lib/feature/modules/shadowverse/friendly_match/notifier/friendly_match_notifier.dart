import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';

import '../data/api/shadowverse_api.dart';
import '../data/dto/request/friendly_match_request.dart';
import '../domain/friendly_match_template.dart';
import '../state/friendly_match_state.dart';

part 'friendly_match_notifier.g.dart';

@riverpod
class FriendlyMatchNotifier extends _$FriendlyMatchNotifier {
  @override
  FriendlyMatchState build() {
    // 로그인한 사용자 이름을 보낸 사람으로 쓴다.
    final globalName = ref.watch(
      currentUserStateProvider.select((s) => s.globalName),
    );

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

  /// 입력한 모집 글을 보내고 봇의 결과 문구를 돌려준다.
  Future<String> submit() {
    final template = FriendlyMatchTemplate(
      version: state.version,
      mode: state.mode,
      platform: state.platform,
      roomNumber: state.roomNumber,
      message: state.message,
      sender: state.sender,
    );
    return ref
        .read(shadowverseApiProvider)
        .friendlyMatch(FriendlyMatchRequest(template));
  }

  /// 초기화
  void clear() {
    final globalName = ref.read(currentUserStateProvider).globalName;
    state = FriendlyMatchState.initial().copyWith(sender: globalName);
  }
}

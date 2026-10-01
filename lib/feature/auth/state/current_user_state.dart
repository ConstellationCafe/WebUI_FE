import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_user_state.freezed.dart';

/// 로그인한 사용자 정보. `/auth/me` 응답은 CurrentUserResponse가 변환한다.
@freezed
abstract class CurrentUserState with _$CurrentUserState {
  const factory CurrentUserState({
    required String userId,
    required String globalName,
    required List<String> roles,
    required String avatarUrl,
  }) = _CurrentUserState;

  factory CurrentUserState.initial() => const CurrentUserState(
    userId: "",
    globalName: "",
    roles: [],
    avatarUrl: "",
  );
}

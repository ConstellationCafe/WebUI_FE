import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_user_state.freezed.dart';
part 'current_user_state.g.dart';

@freezed
abstract class CurrentUserState with _$CurrentUserState {
  const factory CurrentUserState({
    @JsonKey(name: 'discordId') required String userId,
    required String globalName,
    required List<String> roles,
    @JsonKey(name: 'avatar') required String avatarUrl,
  }) = _CurrentUserState;

  factory CurrentUserState.initial() => const CurrentUserState(
    userId: "",
    globalName: "",
    roles: [],
    avatarUrl: "",
  );

  factory CurrentUserState.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserStateFromJson(json);
}
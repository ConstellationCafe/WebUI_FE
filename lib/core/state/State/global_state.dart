import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_state.freezed.dart';
part 'global_state.g.dart';

@freezed
abstract class GlobalState with _$GlobalState {
  const factory GlobalState({
    @JsonKey(name: 'discordId') required String userId,
    required String globalName,
    required List<String> roles,
    @JsonKey(name: 'avatar') required String avatarUrl,
  }) = _GlobalState;

  factory GlobalState.initial() => const GlobalState(
    userId: "",
    globalName: "",
    roles: [],
    avatarUrl: "",
  );

  factory GlobalState.fromJson(Map<String, dynamic> json) =>
      _$GlobalStateFromJson(json);
}
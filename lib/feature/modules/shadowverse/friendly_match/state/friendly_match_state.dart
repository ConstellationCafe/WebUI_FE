import 'package:freezed_annotation/freezed_annotation.dart';

part 'friendly_match_state.freezed.dart';
part 'friendly_match_state.g.dart';

@freezed
abstract class FriendlyMatchState with _$FriendlyMatchState {
  const factory FriendlyMatchState({
    required String version,
    required String mode,
    required String platform,
    required String roomNumber,
    required String message,
    required String sender,
  }) = _FriendlyMatchState;

  /// 초기 상태
  factory FriendlyMatchState.initial() => const FriendlyMatchState(
    version: "",
    mode: "",
    platform: "",
    roomNumber: "",
    message: "",
    sender: "",
  );

  /// JSON 역직렬화
  factory FriendlyMatchState.fromJson(Map<String, dynamic> json) =>
      _$FriendlyMatchStateFromJson(json);
}
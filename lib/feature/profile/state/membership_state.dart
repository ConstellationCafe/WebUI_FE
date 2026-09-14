import 'package:freezed_annotation/freezed_annotation.dart';

part 'membership_state.freezed.dart';
part 'membership_state.g.dart';

@freezed
abstract class MembershipState with _$MembershipState {
  const factory MembershipState({
    @Default(true) bool isLoading,
    required String username,
    String? uid1,
    String? uid2,
    String? role,
    @Default("0") String coin,
    String? s1Data,
    String? s2Data,
    String? guild,
    required String joinAt,
    required String avatar,
  }) = _MembershipState;

  factory MembershipState.initial() => const MembershipState(
    isLoading: true,
    username: "",
    joinAt: "",
    avatar: "",
  );

  factory MembershipState.fromJson(Map<String, dynamic> json) =>
      _$MembershipStateFromJson(json);

  // 기존 legacy의 List 기반 생성을 위한 static 메서드
  factory MembershipState.fromList(List<String> result) {
    return MembershipState(
      isLoading: false,
      username: result[0],
      uid1: result[1],
      uid2: result[2],
      role: result[3],
      coin: result[4],
      s1Data: result[5],
      s2Data: result[6],
      guild: result[7],
      joinAt: result[8],
      avatar: result[9],
    );
  }
}
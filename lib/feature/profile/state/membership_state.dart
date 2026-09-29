import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/membership.dart';

part 'membership_state.freezed.dart';

/// 프로필 화면 상태: 회원증 정보, 입력 중인 UID·길드, 서버에 저장된 값.
@freezed
abstract class MembershipState with _$MembershipState {
  const MembershipState._();

  const factory MembershipState({
    @Default(true) bool isLoading,
    @Default(false) bool hasError,
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

    /// 서버에 저장된 값. 입력값과 비교해 바뀐 항목만 저장한다.
    String? savedUid1,
    String? savedUid2,
    String? savedGuild,
  }) = _MembershipState;

  factory MembershipState.initial() => const MembershipState(
    isLoading: true,
    username: "",
    joinAt: "",
    avatar: "",
  );

  factory MembershipState.fromMembership(Membership membership) {
    return MembershipState(
      isLoading: false,
      username: membership.username,
      uid1: membership.uid1,
      uid2: membership.uid2,
      role: membership.role,
      coin: membership.coin,
      s1Data: membership.s1Data,
      s2Data: membership.s2Data,
      guild: membership.guild,
      joinAt: membership.joinAt,
      avatar: membership.avatar,
      savedUid1: membership.uid1,
      savedUid2: membership.uid2,
      savedGuild: membership.guild,
    );
  }

  bool get uid1Changed => uid1 != savedUid1;
  bool get uid2Changed => uid2 != savedUid2;
  bool get guildChanged => guild != savedGuild;
}

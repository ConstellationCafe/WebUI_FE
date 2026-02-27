

import 'package:constellation_cafe/core/state/Provider/GlobalStateProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:constellation_cafe/data/api/discordBot/MembershipAPI.dart';
import '../State/State.dart';


class MembershipStateNotifier extends StateNotifier<MembershipState> {
  final MembershipAPI membershipApi;
  String membershipID = "test";

  String? _initialUid1;
  String? _initialUid2;
  String? _initialGuild;

  bool get uid1Changed => state.uid1 != _initialUid1;
  bool get uid2Changed => state.uid2 != _initialUid2;
  bool get guildChanged => state.guild != _initialGuild;

  /// 생성자
  MembershipStateNotifier(this.membershipApi) : super(
      MembershipState.initial()
  );

  /// 상태 초기화
  Future<void> initialize(Ref ref) async {
    final globalState = ref.read(globalStateProvider);
    membershipID = globalState.userId;
    String avatar = globalState.avatarUrl;
    final data = await membershipApi.createCard([membershipID]);
    final raw = data["payload"]?["result"];
    final List<String> result = List<String>.from(
      raw.map((e) => e?.toString() ?? ""),
    );
    result.add(avatar);
    state = MembershipState.fromList(result);
    _initialUid1 = state.uid1;
    _initialUid2 = state.uid2;
    _initialGuild = state.guild;
  }

  /// 상태 업데이트
  // TODO : 입력이 ""이면 원래 값으로 되돌리기
  void update({
    String? uid1,
    String? uid2,
    String? guild
  }) {
    state = state.copyWith(
      uid1: _resolveField(uid1, state.uid1, _initialUid1),
      uid2: _resolveField(uid2, state.uid2, _initialUid2),
      guild: _resolveField(guild, state.guild, _initialGuild),
    );
  }

  String? _resolveField(
      String? newValue,
      String? currentValue,
      String? initialValue,
      ) {
    if (newValue == null) return currentValue;
    if (newValue.isEmpty) return initialValue;
    return newValue;
  }

  /// JSON으로부터 상태 세팅
  void setFromList(List<String> list) {
    state = MembershipState.fromList(list);
  }

  /// 상태를 JSON으로 export
  Map<String, dynamic> toJson() {
    return state.toJson();
  }

  Future<List<String>> saveIfChanged() async {
    List<String> results = [];
    String result = "";
    if (uid1Changed && (state.uid1?.isNotEmpty ?? false)) {
      result = await _saveUID(state.uid1!, state.username);
      results.add(result);
      _initialUid1 = state.uid1;
    } if (uid2Changed && (state.uid2?.isNotEmpty ?? false)) {
      result = await _saveUID(state.uid2!, state.username);
      results.add(result);
      _initialUid2 = state.uid2;
    } if (guildChanged && (state.guild?.isNotEmpty ?? false)) {
      result = await _saveGuild(state.guild!, state.username);
      results.add(result);
      _initialGuild = state.guild;
    }
    return results;
  }

  Future<String> _saveUID(String uid, String username) async {
    String version = "";
    if (uid.length == 9) {
      version = "s1";
    } else {
      version = "s2";
    }
    return await membershipApi.updateUID([membershipID, version, uid, username]);
  }

  Future<String> _saveGuild(String guild, String username) async {
    String version = "s2";
    return await membershipApi.updateGuild([membershipID, version, guild, username]);
  }

  /// 초기화
  void clear() {
    state = MembershipState.initial();
  }
}
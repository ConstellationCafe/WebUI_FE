import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/Notifier/global_state_notifier.dart';
import '../state/membership_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:constellation_cafe/core/di/ApiProvider.dart';

part 'membership_notifier.g.dart';

@riverpod
class MembershipNotifier extends _$MembershipNotifier {
  String _membershipID = "test";
  String? _initialUid1;
  String? _initialUid2;
  String? _initialGuild;

  bool get uid1Changed => state.uid1 != _initialUid1;
  bool get uid2Changed => state.uid2 != _initialUid2;
  bool get guildChanged => state.guild != _initialGuild;

  @override
  MembershipState build() {
    // 초기 상태 반환
    return MembershipState.initial();
  }

  /// 상태 초기화
  Future<void> initialize() async {
    final membershipApi = ref.read(membershipApiProvider);
    final globalState = ref.read(globalStateProvider);

    _membershipID = globalState.userId;
    String avatar = globalState.avatarUrl;

    final data = await membershipApi.createCard([_membershipID]);
    final raw = data["payload"]?["result"];

    final List<String> result = List<String>.from(
      raw.map((e) => e?.toString() ?? ""),
    );
    result.add(avatar);

    state = MembershipState.fromList(result);

    // 초기값 백업
    _initialUid1 = state.uid1;
    _initialUid2 = state.uid2;
    _initialGuild = state.guild;
  }

  /// 상태 업데이트 ("" 입력 시 초기값으로 복구)
  void update({String? uid1, String? uid2, String? guild}) {
    state = state.copyWith(
      uid1: _resolveField(uid1, state.uid1, _initialUid1),
      uid2: _resolveField(uid2, state.uid2, _initialUid2),
      guild: _resolveField(guild, state.guild, _initialGuild),
    );
  }

  String? _resolveField(String? newValue, String? currentValue, String? initialValue) {
    if (newValue == null) return currentValue;
    if (newValue.isEmpty) return initialValue;
    return newValue;
  }

  /// 변경사항 저장
  Future<List<String>> saveIfChanged() async {
    final membershipApi = ref.read(membershipApiProvider);
    List<String> results = [];

    if (uid1Changed && (state.uid1?.isNotEmpty ?? false)) {
      final res = await _saveUID(membershipApi, state.uid1!, state.username);
      results.add(res);
      _initialUid1 = state.uid1;
    }
    if (uid2Changed && (state.uid2?.isNotEmpty ?? false)) {
      final res = await _saveUID(membershipApi, state.uid2!, state.username);
      results.add(res);
      _initialUid2 = state.uid2;
    }
    if (guildChanged && (state.guild?.isNotEmpty ?? false)) {
      final res = await _saveGuild(membershipApi, state.guild!, state.username);
      results.add(res);
      _initialGuild = state.guild;
    }
    return results;
  }

  Future<String> _saveUID(dynamic api, String uid, String username) async {
    String version = uid.length == 9 ? "s1" : "s2";
    return await api.updateUID([_membershipID, version, uid, username]);
  }

  Future<String> _saveGuild(dynamic api, String guild, String username) async {
    return await api.updateGuild([_membershipID, "s2", guild, username]);
  }

  void clear() {
    state = MembershipState.initial();
  }
}
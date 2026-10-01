import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';

import '../data/api/membership_api.dart';
import '../domain/model/membership.dart';
import '../state/membership_state.dart';

part 'membership_notifier.g.dart';

/// 회원증은 봇 명령으로 만들어지므로 프로필 화면을 오갈 때마다 다시 만들지 않도록
/// 앱 수명 동안 유지한다.
@Riverpod(keepAlive: true)
class MembershipNotifier extends _$MembershipNotifier {
  String _membershipID = '';

  bool _initialized = false;
  bool _initializing = false;

  bool get uid1Changed => state.uid1Changed;
  bool get uid2Changed => state.uid2Changed;
  bool get guildChanged => state.guildChanged;

  @override
  MembershipState build() {
    ref.onDispose(() {
      _initialized = false;
      _initializing = false;
    });

    return MembershipState.initial();
  }

  /// 회원증을 조회한다. 실패하면 [MembershipState.hasError]로 알린다.
  Future<void> initialize() async {
    if (_initialized || _initializing) {
      return;
    }
    _initializing = true;
    state = state.copyWith(isLoading: true, hasError: false);
    try {
      final membershipApi = ref.read(membershipApiProvider);
      final currentUser = ref.read(currentUserStateProvider);
      _membershipID = currentUser.userId;

      final card = await membershipApi.createCard([currentUser.userId]);
      state = MembershipState.fromMembership(
        card.toDomain(avatar: currentUser.avatarUrl),
      );
      _initialized = true;
    } catch (_) {
      state = state.copyWith(isLoading: false, hasError: true);
    } finally {
      _initializing = false;
    }
  }

  void update({String? uid1, String? uid2, String? guild}) {
    state = state.copyWith(
      uid1: _resolveField(uid1, state.uid1, state.savedUid1),
      uid2: _resolveField(uid2, state.uid2, state.savedUid2),
      guild: _resolveField(guild, state.guild, state.savedGuild),
    );
  }

  String? _resolveField(
    String? newValue,
    String? currentValue,
    String? initialValue,
  ) {
    if (newValue == null) {
      return currentValue;
    }

    if (newValue.isEmpty) {
      return initialValue;
    }

    return newValue;
  }

  Future<List<String>> saveIfChanged() async {
    final membershipApi = ref.read(membershipApiProvider);
    final results = <String>[];

    if (state.uid1Changed && (state.uid1?.isNotEmpty ?? false)) {
      final uid = state.uid1!;
      results.add(await _saveUID(membershipApi, uid, state.username));
      state = state.copyWith(savedUid1: uid);
    }

    if (state.uid2Changed && (state.uid2?.isNotEmpty ?? false)) {
      final uid = state.uid2!;
      results.add(await _saveUID(membershipApi, uid, state.username));
      state = state.copyWith(savedUid2: uid);
    }

    if (state.guildChanged && (state.guild?.isNotEmpty ?? false)) {
      final guild = state.guild!;
      results.add(await _saveGuild(membershipApi, guild, state.username));
      state = state.copyWith(savedGuild: guild);
    }

    return results;
  }

  Future<String> _saveUID(MembershipAPI api, String uid, String username) {
    final version = Membership.gameVersionOfUid(uid);
    return api.updateUID([_membershipID, version, uid, username]);
  }

  Future<String> _saveGuild(MembershipAPI api, String guild, String username) {
    return api.updateGuild([
      _membershipID,
      Membership.guildGameVersion,
      guild,
      username,
    ]);
  }

  void clear() {
    state = MembershipState.initial();

    _initialized = false;
    _initializing = false;
  }
}

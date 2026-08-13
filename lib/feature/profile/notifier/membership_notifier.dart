import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';

import '../state/membership_state.dart';

part 'membership_notifier.g.dart';

@Riverpod(keepAlive: true)
class MembershipNotifier extends _$MembershipNotifier {
  String _membershipID = '';

  String? _initialUid1;
  String? _initialUid2;
  String? _initialGuild;

  bool _initialized = false;
  bool _initializing = false;

  bool get uid1Changed => state.uid1 != _initialUid1;
  bool get uid2Changed => state.uid2 != _initialUid2;
  bool get guildChanged => state.guild != _initialGuild;

  @override
  MembershipState build() {
    ref.onDispose(() {
      _initialized = false;
      _initializing = false;
    });

    return MembershipState.initial();
  }

  Future<void> initialize() async {
    if (_initialized || _initializing) {
      return;
    }

    _initializing = true;

    try {
      final membershipApi = ref.read(membershipApiProvider);
      final globalState = ref.read(currentUserStateProvider);

      _membershipID = globalState.userId;
      final avatar = globalState.avatarUrl;

      state = state.copyWith(isLoading: true);

      final data = await membershipApi.createCard([
        _membershipID,
      ]);

      final payload = data['payload'];
      final raw = payload?['result'];

      final List<String> result = List<String>.from(
        raw.map((e) => e?.toString() ?? ''),
      );

      result.add(avatar);

      state = MembershipState.fromList(result);

      _initialUid1 = state.uid1;
      _initialUid2 = state.uid2;
      _initialGuild = state.guild;

      _initialized = true;
    } finally {
      _initializing = false;

      if (!_initialized) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  void update({
    String? uid1,
    String? uid2,
    String? guild,
  }) {
    state = state.copyWith(
      uid1: _resolveField(
        uid1,
        state.uid1,
        _initialUid1,
      ),
      uid2: _resolveField(
        uid2,
        state.uid2,
        _initialUid2,
      ),
      guild: _resolveField(
        guild,
        state.guild,
        _initialGuild,
      ),
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

    if (uid1Changed && (state.uid1?.isNotEmpty ?? false)) {
      final result = await _saveUID(
        membershipApi,
        state.uid1!,
        state.username,
      );

      results.add(result);
      _initialUid1 = state.uid1;
    }

    if (uid2Changed && (state.uid2?.isNotEmpty ?? false)) {
      final result = await _saveUID(
        membershipApi,
        state.uid2!,
        state.username,
      );

      results.add(result);
      _initialUid2 = state.uid2;
    }

    if (guildChanged && (state.guild?.isNotEmpty ?? false)) {
      final result = await _saveGuild(
        membershipApi,
        state.guild!,
        state.username,
      );

      results.add(result);
      _initialGuild = state.guild;
    }

    return results;
  }

  Future<String> _saveUID(
      dynamic api,
      String uid,
      String username,
      ) async {
    final version = uid.length == 9 ? 's1' : 's2';

    return api.updateUID([
      _membershipID,
      version,
      uid,
      username,
    ]);
  }

  Future<String> _saveGuild(
      dynamic api,
      String guild,
      String username,
      ) async {
    return api.updateGuild([
      _membershipID,
      's2',
      guild,
      username,
    ]);
  }

  void clear() {
    state = MembershipState.initial();

    _initialized = false;
    _initializing = false;

    _initialUid1 = null;
    _initialUid2 = null;
    _initialGuild = null;
  }
}
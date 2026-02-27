import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../State/State.dart';
import '../Notifier/StateNotifier.dart';
import 'package:constellation_cafe/core/state/Provider/GlobalStateProvider.dart';

final friendlyMatchProvider =
  StateNotifierProvider.autoDispose<FriendlyMatchStateNotifier, FriendlyMatchState>(
        (ref) {
          final globalState = ref.read(globalStateProvider);
          final notifier = FriendlyMatchStateNotifier();
          notifier.update(sender: globalState.globalName);
          return notifier;
        },
  );
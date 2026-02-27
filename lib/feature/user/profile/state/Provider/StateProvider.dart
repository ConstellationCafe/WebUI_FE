import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:constellation_cafe/core/di/ApiProvider.dart';
import '../State/State.dart';
import '../Notifier/StateNotifier.dart';

final membershipProvider =
  StateNotifierProvider.autoDispose<MembershipStateNotifier, MembershipState>(
        (ref) {
          final membershipApi = ref.watch(membershipApiProvider);
          final notifier = MembershipStateNotifier(membershipApi);
          notifier.initialize(ref);  // 내부적으로 createCard 호출해서 state 채움
          return notifier;
        },
  );

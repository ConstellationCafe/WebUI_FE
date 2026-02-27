import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:constellation_cafe/core/di/ApiProvider.dart';

import '../Notifier/GlobalStateNotifier.dart';
import '../State/GlobalState.dart';

final globalStateProvider =
  StateNotifierProvider<GlobalStateNotifier, GlobalState>(
        (ref) {
          final loginApi = ref.watch(loginApiProvider);
          final notifier = GlobalStateNotifier(loginApi);
          // initialize()는 로그인 이후 ref.read()로 호출
          return notifier;
        },
  );

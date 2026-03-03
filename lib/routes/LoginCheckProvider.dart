import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/di/ApiProvider.dart';
import 'package:constellation_cafe/data/model/response/backend/ApiResponse.dart';

class LoginCheckNotifier extends AsyncNotifier<bool> {
  bool parseIsLogin(ApiResponse api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['isLogin'] == true;
  }

  bool parseRefreshHint(ApiResponse api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['refreshHint'] == true;
  }

  bool isUnauthorized(ApiResponse api) {
    final s = api.error?.status;
    return s == 401 || s == 403;
  }

  @override
  Future<bool> build() async {
    final jwt = ref.read(jwtApiProvider);

    try {
      final res = await jwt.check();

      if (res.success == true) {
        final isLogin = parseIsLogin(res);
        if (isLogin) return true;

        final hint = parseRefreshHint(res);
        if (!hint) return false;

        final refreshRes = await jwt.refresh();
        if (refreshRes != true) return false;

        final res2 = await jwt.check();
        return res2.success == true && parseIsLogin(res2);
      }

      if (isUnauthorized(res)) {
        final refreshRes = await jwt.refresh();
        if (refreshRes != true) return false;

        final res2 = await jwt.check();
        return res2.success == true && parseIsLogin(res2);
      }

      return false;
    } catch (_) {
      return false;
    }
  }

  // 로그아웃 즉시 반영용
  void forceLogout() {
    state = const AsyncData(false);
  }
}

final loginCheckProvider =
  AsyncNotifierProvider<LoginCheckNotifier, bool>(LoginCheckNotifier.new);

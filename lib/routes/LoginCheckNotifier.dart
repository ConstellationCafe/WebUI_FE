import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/di/ApiProvider.dart';
import 'package:constellation_cafe/data/model/response/backend/ApiResponse.dart';

class LoginCheckNotifier extends AsyncNotifier<bool> {
  bool _forcedLogout = false;

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
    // 로그아웃 버튼 누른 직후에는, 어떤 재빌드/재체크가 와도 무조건 로그아웃 유지
    if (_forcedLogout) return false;

    final jwt = ref.read(jwtApiProvider);

    try {
      final res = await jwt.check();

      // 정상 응답
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

      // 401/403이면 refresh 시도
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

  /// 로그아웃 버튼 누르는 순간 즉시 false로 내려서 redirect 레이스 차단
  void forceLogout() {
    _forcedLogout = true;
    state = const AsyncData(false);
  }

  /// (선택) 로그인 성공 직후 바로 true로 올리고 싶을 때
  void forceLogin() {
    _forcedLogout = false;
    state = const AsyncData(true);
  }

  /// (선택) 서버에 다시 확인하고 싶을 때
  Future<void> refresh() async {
    if (_forcedLogout) return;
    state = const AsyncLoading();
    state = AsyncData(await build());
  }
}

final loginCheckProvider =
AsyncNotifierProvider<LoginCheckNotifier, bool>(LoginCheckNotifier.new);
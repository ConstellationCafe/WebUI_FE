import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/di/ApiProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_check_notifier.g.dart';

@riverpod
class LoginCheckNotifier extends _$LoginCheckNotifier {
  bool _forcedLogout = false;

  @override
  Future<bool> build() async {
    if (_forcedLogout) return false;

    final jwt = ref.read(jwtApiProvider);

    try {
      final res = await jwt.check();

      // 정상 응답 처리
      if (res.success == true) {
        if (_parseIsLogin(res)) return true;
        if (!_parseRefreshHint(res)) return false;

        return await _attemptRefresh();
      }

      // 권한 없음(401, 403) 처리
      if (_isUnauthorized(res)) {
        return await _attemptRefresh();
      }

      return false;
    } catch (_) {
      return false;
    }
  }

  /// 토큰 갱신 시도
  Future<bool> _attemptRefresh() async {
    final jwt = ref.read(jwtApiProvider);
    final refreshRes = await jwt.refresh();

    if (refreshRes != true) return false;

    final res2 = await jwt.check();
    return res2.success == true && _parseIsLogin(res2);
  }

  bool _parseIsLogin(dynamic api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['isLogin'] == true;
  }

  bool _parseRefreshHint(dynamic api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['refreshHint'] == true;
  }

  bool _isUnauthorized(dynamic api) {
    final s = api.error?.status;
    return s == 401 || s == 403;
  }

  /// 강제 로그아웃 (레이스 컨디션 방지)
  void forceLogout() {
    _forcedLogout = true;
    state = const AsyncData(false);
  }

  /// 강제 로그인 상태 주입
  void forceLogin() {
    _forcedLogout = false;
    state = const AsyncData(true);
  }

  /// 상태 수동 갱신
  Future<void> recheck() async {
    if (_forcedLogout) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
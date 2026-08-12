import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';

import 'current_user_state_notifier.dart';

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
        if (_parseIsLogin(res)) {
          return await _onLoginSuccess();
        }
        if (!_parseRefreshHint(res)) return false;

        return await _tryJwtRefresh();
      }
      // 권한 없음(401, 403) 처리
      else if (_isUnauthorized(res)) {
        return await _tryJwtRefresh();
      }
      else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> _tryJwtRefresh() async {
    final jwt = ref.read(jwtApiProvider);
    final refreshRes = await jwt.refresh();

    if (refreshRes != true) return false;

    final checkRes = await jwt.check();
    if (checkRes.success == true && _parseIsLogin(checkRes)) {
      return await _onLoginSuccess();
    }
    else {
      return false;
    }
  }

  bool _parseIsLogin(dynamic api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['isLogin'] == true;
  }

  Future<bool> _onLoginSuccess() async {
    await ref.read(currentUserStateProvider.notifier).initialize();
    return true;
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
  // void forceLogin() {
  //   _forcedLogout = false;
  //   state = const AsyncData(true);
  // }

  /// 상태 수동 갱신
  Future<void> recheck() async {
    if (_forcedLogout) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
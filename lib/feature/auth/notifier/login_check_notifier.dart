import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';

import '../state/login_status.dart';
import 'current_user_state_notifier.dart';

part 'login_check_notifier.g.dart';

@riverpod
class LoginCheckNotifier extends _$LoginCheckNotifier {
  bool _forcedLogout = false;

  @override
  Future<LoginStatus> build() async {
    if (_forcedLogout) return LoginStatus.loggedOut;
    final jwt = ref.read(jwtApiProvider);
    try {
      final res = await jwt.check();
      // 정상 응답 처리
      if (res.success == true) {
        if (_parseIsLogin(res)) {
          return await _onLoginSuccess(_parseRoomSelected(res));
        }
        if (!_parseRefreshHint(res)) return LoginStatus.loggedOut;

        return await _tryJwtRefresh();
      }
      // 권한 없음(401, 403) 처리
      else if (_isUnauthorized(res)) {
        return await _tryJwtRefresh();
      } else {
        return LoginStatus.loggedOut;
      }
    } catch (_) {
      return LoginStatus.loggedOut;
    }
  }

  Future<LoginStatus> _tryJwtRefresh() async {
    final jwt = ref.read(jwtApiProvider);
    final refreshRes = await jwt.refresh();

    if (refreshRes != true) return LoginStatus.loggedOut;

    final checkRes = await jwt.check();
    if (checkRes.success == true && _parseIsLogin(checkRes)) {
      return await _onLoginSuccess(_parseRoomSelected(checkRes));
    } else {
      return LoginStatus.loggedOut;
    }
  }

  bool _parseIsLogin(dynamic api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['isLogin'] == true;
  }

  /// ADR-0001: botId(=채팅방)까지 선택되어 로그인이 완료됐는지 여부.
  bool _parseRoomSelected(dynamic api) {
    final resp = api.response as Map<String, dynamic>?;
    return resp?['roomSelected'] == true;
  }

  Future<LoginStatus> _onLoginSuccess(bool roomSelected) async {
    // ADR-0001: roles(관리자 여부)가 방(botId) 단위로 갈리므로, 아직
    // 채팅방을 선택하지 않은 토큰으로는 /auth/me를 불러도 의미가 없다.
    // 채팅방 선택이 끝난 뒤에만(또는 새로고침으로 이미 끝나 있던 경우)
    // 불러온다.
    if (roomSelected) {
      await ref.read(currentUserStateProvider.notifier).initialize();
    }
    return LoginStatus(isLoggedIn: true, roomSelected: roomSelected);
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
    state = const AsyncData(LoginStatus.loggedOut);
  }

  /// 강제 로그인 상태 주입
  // void forceLogin() {
  //   _forcedLogout = false;
  //   state = const AsyncData(true);
  // }

  /// 상태 수동 갱신 (채팅방 선택 완료 등, 서버 상태가 바뀐 뒤 호출)
  Future<void> recheck() async {
    if (_forcedLogout) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}

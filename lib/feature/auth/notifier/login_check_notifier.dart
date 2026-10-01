import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/feature/auth/data/repository/jwt.dart';
import 'package:constellation_cafe/feature/auth/data/repository/login.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';

import '../data/dto/response/auth_check_response.dart';
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
      final res = AuthCheckResponse.fromApiResponse(await jwt.check());
      // 정상 응답 처리
      if (res.success) {
        if (res.isLogin) {
          return await _onLoginSuccess(res.roomSelected);
        }
        if (!res.refreshHint) return LoginStatus.loggedOut;

        return await _tryJwtRefresh();
      }
      // 권한 없음(401, 403) 처리
      else if (res.isUnauthorized) {
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

    final checkRes = AuthCheckResponse.fromApiResponse(await jwt.check());
    if (checkRes.success && checkRes.isLogin) {
      return await _onLoginSuccess(checkRes.roomSelected);
    } else {
      return LoginStatus.loggedOut;
    }
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

  /// 강제 로그아웃 (레이스 컨디션 방지)
  void forceLogout() {
    _forcedLogout = true;
    state = const AsyncData(LoginStatus.loggedOut);
  }

  /// 로그아웃. 먼저 로그아웃 상태로 바꿔 보호된 화면을 닫고, 서버 세션 종료 요청이
  /// 실패해도(이미 만료 등) 로컬 사용자·채팅방 상태는 반드시 지운다.
  Future<void> logout() async {
    // 사용자·채팅방 상태는 앱 수명 동안 유지되는 provider라 await 뒤에도 안전하게 지울 수 있다.
    final loginApi = ref.read(loginApiProvider);
    final currentUser = ref.read(currentUserStateProvider.notifier);
    final currentGuild = ref.read(currentGuildStateProvider.notifier);

    forceLogout();
    try {
      await loginApi.logout();
    } catch (_) {
      // 서버 세션은 토큰 만료로도 끝나므로 화면 로그아웃을 막지 않는다.
    }
    currentUser.clear();
    currentGuild.clear();
  }

  /// 상태 수동 갱신 (채팅방 선택 완료 등, 서버 상태가 바뀐 뒤 호출)
  Future<void> recheck() async {
    if (_forcedLogout) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}

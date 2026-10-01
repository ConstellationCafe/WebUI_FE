import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/feature/auth/data/repository/login.dart';

import '../../module_config/notifier/module_config_notifier.dart';
import '../data/dto/response/current_user_response.dart';
import '../state/current_user_state.dart';

part 'current_user_state_notifier.g.dart';

/// 로그인한 사용자는 화면을 오가도 다시 조회하지 않도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 로그인 확인 후 다시 불러온다.)
@Riverpod(keepAlive: true)
class CurrentUserStateNotifier extends _$CurrentUserStateNotifier {
  bool _isInitialized = false;
  int _request = 0;
  Future<void>? _initialization;

  @override
  CurrentUserState build() {
    return CurrentUserState.initial();
  }

  /// 초기화: 로그인 이후 명시적으로 호출
  Future<void> initialize() {
    if (_isInitialized) return Future.value();
    final pending = _initialization;
    if (pending != null) return pending;
    final request = ++_request;
    final initialization = _initialize(request);
    _initialization = initialization;
    return initialization.whenComplete(() {
      if (request == _request) _initialization = null;
    });
  }

  Future<void> _initialize(int request) async {
    final me = await ref.read(loginApiProvider).me();
    if (!ref.mounted || request != _request) return;
    final body = me.response;
    if (body is! Map<String, dynamic>) {
      throw const FormatException('현재 사용자 응답 형식이 올바르지 않습니다.');
    }
    state = CurrentUserResponse.fromJson(body).toState();
    await ref.read(moduleConfigProvider.notifier).load();
    if (!ref.mounted || request != _request) return;
    _isInitialized = true;
  }

  /// ADR-0001: roles(관리자 여부)는 방(botId) 단위로 갈린다. 채팅방을
  /// 새로 선택/변경했을 때는 이미 초기화되어 있어도 강제로 다시 불러와야
  /// 이전 방의 roles가 남아있지 않다.
  Future<void> refresh() async {
    clear();
    await initialize();
  }

  /// 상태 업데이트
  void update({
    String? userId,
    String? globalName,
    List<String>? roles,
    String? avatarUrl,
  }) {
    state = state.copyWith(
      userId: userId ?? state.userId,
      globalName: globalName ?? state.globalName,
      roles: roles ?? state.roles,
      avatarUrl: avatarUrl ?? state.avatarUrl,
    );
  }

  /// 초기화
  void clear() {
    _request++;
    _initialization = null;
    state = CurrentUserState.initial();
    _isInitialized = false;
    ref.read(moduleConfigProvider.notifier).clear();
  }
}

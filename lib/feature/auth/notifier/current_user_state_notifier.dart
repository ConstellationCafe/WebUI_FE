import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/current_user_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:constellation_cafe/di/ApiProvider.dart';

part 'current_user_state_notifier.g.dart';

@Riverpod(keepAlive: true)  // 새로고침해도 유지되게
class CurrentUserStateNotifier extends _$CurrentUserStateNotifier {
  bool _isInitialized = false;

  @override
  CurrentUserState build() {
    return CurrentUserState.initial();
  }

  /// 초기화: 로그인 이후 명시적으로 호출
  Future<void> initialize() async {
    if (!_isInitialized) {
      final loginApi = ref.read(loginApiProvider);
      final me = await loginApi.me();

      if (me.response != null) {
        state = CurrentUserState.fromJson(me.response!);
        _isInitialized = true;
      }
    }
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

  /// JSON으로부터 직접 세팅
  void setFromJson(Map<String, dynamic> json) {
    state = CurrentUserState.fromJson(json);
    _isInitialized = true;
  }

  /// 상태를 JSON으로 변환
  Map<String, dynamic> toJson() => state.toJson();

  /// 초기화
  void clear() {
    state = CurrentUserState.initial();
    _isInitialized = false;
  }
}